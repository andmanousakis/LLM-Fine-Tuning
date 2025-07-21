import os
import logging
import torch
import traceback
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from peft import PeftModel
from dotenv import load_dotenv

# Device selection.
USE_UNSLOTH = torch.cuda.is_available()
DEVICE = "cuda" if USE_UNSLOTH else "cpu"

if USE_UNSLOTH:
    import unsloth

# Now continue with everything else...
# Load .env.
load_dotenv()

BASE_DIR = os.environ.get("BASE_DIR", os.getcwd())
ADAPTERS_DIR = os.environ.get("ADAPTERS_DIR", os.path.join(BASE_DIR, "adapters"))

# Logging.
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

logger.info(f"Using device: {DEVICE}")

# Conditional imports.
if USE_UNSLOTH:
    from unsloth import FastLanguageModel
else:
    from transformers import AutoModelForCausalLM, AutoTokenizer

def load_model_and_tokenizer():
    logger.info(
        f"Loading Qwen3-0.6B with {'Unsloth FastLanguageModel' if USE_UNSLOTH else 'vanilla Transformers'}..."
    )
    try:
        if USE_UNSLOTH:
            model, tokenizer = FastLanguageModel.from_pretrained(
                model_name="Qwen/Qwen3-0.6B",
                load_in_4bit=True,
            )
            model = PeftModel.from_pretrained(model, ADAPTERS_DIR)
        else:
            tokenizer = AutoTokenizer.from_pretrained("Qwen/Qwen3-0.6B")
            model = AutoModelForCausalLM.from_pretrained("Qwen/Qwen3-0.6B")
            model = PeftModel.from_pretrained(model, ADAPTERS_DIR)
            model = model.to(DEVICE)
        logger.info("Model loaded successfully.")
        return model, tokenizer
    except Exception as e:
        logger.error("Failed to load model: %s", str(e))
        raise

model, tokenizer = load_model_and_tokenizer()

# Initialize FastAPI.
app = FastAPI(title="LLM Inference API (Unsloth or CPU)")

class GenerateRequest(BaseModel):
    prompt: str

class GenerateResponse(BaseModel):
    response: str

@app.post("/generate", response_model=GenerateResponse)
async def generate(request: GenerateRequest):
    prompt = request.prompt

    if not prompt or not isinstance(prompt, str):
        logger.warning("Invalid prompt received: %s", prompt)
        raise HTTPException(status_code=422, detail="Invalid or missing 'prompt'")

    try:
        # Tokenize and move inputs to device.
        inputs = tokenizer([prompt], return_tensors="pt")
        inputs = {k: v.to(DEVICE) for k, v in inputs.items()}

        with torch.inference_mode():
            output = model.generate(
                **inputs,
                max_new_tokens=128,
                do_sample=False,
                repetition_penalty=1.5
            )

        response_text = tokenizer.decode(output[0], skip_special_tokens=True).strip()
        logger.info("Generated response for prompt: %s", prompt)
        return GenerateResponse(response=response_text)

    except Exception as e:
        traceback.print_exc()
        logger.error("Model inference error: %s", str(e))
        raise HTTPException(status_code=500, detail=f"Model inference error: {str(e)}")

@app.get("/health")
async def health():
    return {"status": "ok"}
