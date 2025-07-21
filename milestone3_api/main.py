# File: milestone3_api/main.py

import unsloth
import traceback
import os
import re
import logging
import torch
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from peft import PeftModel
from dotenv import load_dotenv
from unsloth import FastLanguageModel

# Load .env.
load_dotenv()

BASE_DIR = os.environ.get("BASE_DIR", os.getcwd())
ADAPTERS_DIR = os.environ.get("ADAPTERS_DIR", os.path.join(BASE_DIR, "adapters"))

# Logging.
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Determine device.
DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
logger.info(f"Using device: {DEVICE}")

# Load model and tokenizer.
def load_model_and_tokenizer():

    # 
    logger.info(f"Loading Qwen3-0.6B with Unsloth FastLanguageModel...")
    try:
        model, tokenizer = FastLanguageModel.from_pretrained(
            model_name="Qwen/Qwen3-0.6B",
            load_in_4bit=(DEVICE == "cuda"),
        )

        
        model = PeftModel.from_pretrained(model, ADAPTERS_DIR)
        logger.info("Model loaded successfully.")
        return model, tokenizer
    except Exception as e:
        logger.error("Failed to load model: %s", str(e))
        raise
model, tokenizer = load_model_and_tokenizer()

# Initialize FastAPI.
app = FastAPI(title="LLM Inference API (Unsloth)")

class GenerateRequest(BaseModel):
    prompt: str

class GenerateResponse(BaseModel):
    response: str

@app.post("/generate", response_model=GenerateResponse)
async def generate(request: GenerateRequest):
    prompt = request.prompt

    # Validate input.
    if not prompt or not isinstance(prompt, str):
        logger.warning("Invalid prompt received: %s", prompt)
        raise HTTPException(status_code=422, detail="Invalid or missing 'prompt'")

    try:
        # Tokenize and move inputs to device.
        inputs = tokenizer([prompt], return_tensors="pt")
        inputs = {k: v.to(DEVICE) for k, v in inputs.items()}

        # Generate output with controlled decoding.
        with torch.inference_mode():
            output = model.generate(
                **inputs,
                max_new_tokens=128,
                do_sample=False,
                repetition_penalty=1.5
            )

        # Decode and clean the output.
        response_text = tokenizer.decode(output[0], skip_special_tokens=True).strip()

        # Logging.
        logger.info("Generated response for prompt: %s", prompt)
        return GenerateResponse(response=response_text)

    except Exception as e:
        traceback.print_exc()
        logger.error("Model inference error: %s", str(e))
        raise HTTPException(status_code=500, detail=f"Model inference error: {str(e)}")

@app.get("/health")
async def health():
    return {"status": "ok"}
