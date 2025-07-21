## [0.2.0] - 2025-07-20

### Added

**Milestone 2: Fine-Tuning**

- Environment setup for LoRA/QLoRA fine-tuning (peft, bitsandbytes, unsloth, etc.).
- Quantization configuration (4-bit quantization with QLoRA).
- LoRA parameter configuration (target modules, rank, alpha).
- Implemented fine-tuning workflow (Trainer/custom loop) on the 100-example subset.
- Monitored training loss and metrics.
- Saved LoRA adapter weights and config (e.g., `adapter_model.safetensors`, `adapter_config.json`).
- Saved training logs and evaluation metrics (e.g., `training_log.txt`).
- Generated and displayed responses from the fine-tuned model on test prompts.

**Milestone 3: API and Containerization**

- Implement FastAPI service with `/generate` and `/health` endpoints.
- Add robust validation and error handling in the API.
- Load base model and LoRA adapters within the API service.
- Create Dockerfile for containerized inference.
- Write requirements.txt for API dependencies.
- Add API usage documentation and Docker instructions in README.

## [0.1.0] - 2025-07-19

### Added

**Milestone 1: Data Exploration**

- Initial notebook for Milestone 1: Dataset exploration and model setup.
- Makefile for environment management (conda and venv options).
- `environment.yml` and `requirements.txt` for reproducible installs.
- Loading and inspection of `yahma/alpaca-cleaned` dataset.
- Statistical analysis and Plotly visualization of instruction and response lengths.
- Printing of 10 sample instruction/input/output examples for qualitative review.
- Creation and saving of a 100-example subset for efficient training.
- Loading of Qwen/Qwen3-0.6B model and tokenizer.
- Automatic device selection (GPU if available, fallback to CPU).
- Out-of-the-box model inference for text generation verification.
- Calculation and reporting of model parameter count and memory requirements.
- Verification that model runs successfully on available hardware.

### Pending for Milestone 2: LLM Fine-tuning with LoRA

- Environment setup for LoRA/QLoRA fine-tuning (peft, bitsandbytes, unsloth, etc.).
- Quantization configuration (4-bit quantization with QLoRA).
- LoRA parameter configuration (target modules, rank, alpha).
- Implement fine-tuning workflow (Trainer/custom loop) on the 100-example subset.
- Monitor training loss and metrics.
- Save LoRA adapter weights and config (e.g., `adapter_model.safetensors`, `adapter_config.json`).
- Save training logs and evaluation metrics (e.g., `training_log.txt`).
- Generate and display responses from the fine-tuned model on test prompts.

### Pending for Milestone 3: API and Containerization (Optional)

- Implement FastAPI service with `/generate` and `/health` endpoints.
- Add robust validation and error handling in the API.
- Load base model and LoRA adapters within the API service.
- Create Dockerfile (multi-stage) for containerized inference.
- Write requirements.txt for API dependencies.
- Add API usage documentation and Docker instructions in README.