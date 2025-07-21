# LLM Fine-tuning

This project is a solution for the **LLM Fine-tuning Project**, demonstrating practical skills in Large Language Model fine-tuning and deployment.

## 📖 Overview

This repository contains code and documentation for:
- Exploring and preprocessing the [`yahma/alpaca-cleaned`](https://huggingface.co/datasets/yahma/alpaca-cleaned) dataset.
- Setting up and running the [`Qwen/Qwen3-0.6B`](https://huggingface.co/Qwen/Qwen3-0.6B) LLM.
- Formatting data for instruction fine-tuning (Alpaca prompt style).
- Fine-tuning the LLM with LoRA/QLoRA.
- Deploying the fine-tuned model as a REST API in Docker.


## 🚀 Milestone 1 & 2 Startup

1. **Clone repo:**

```bash
git clone --single-branch --branch development git@github.com:andmanousakis/LLM-Fine-Tuning.git
```

2. **Navigate to the direcotry:**

```bash
cd LLM-Fine-Tuning
```

3. **Install dependencies with Conda using the provided `Makefile`**:

```bash
make conda
```

3. **(Optional) Activate conda env:** 

```bash
conda activate llm-assessment
```

4. **Run the notebooks. Do not forget to select kernel: `llm-assessment`**


## 🛸 Milestone 3 Startup

5. **(Optional if already installed) Install NVIDIA Container Toolkit:**

```bash
make nvidia-container-toolkit
```

6. **Build and run:**

```bash
GPU: make build-gpu
```

7. **Clean image and containers:**

```bash
GPU: make clean-gpu
```

8. **API usage examples:**

- Health check:

```bash
curl http://localhost:8000/health
```

- Simple prompt:

```bash
curl -X POST http://localhost:8000/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": "What is the capital of France?"}' | jq
```

- Missing prompt:

```bash
curl -X POST http://localhost:8000/generate \
  -H "Content-Type: application/json" \
  -d '{}' | jq
```

- Null prompt:

```bash
curl -X POST http://localhost:8000/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": null}' | jq
```

- Malformed JSON :

```bash
curl -X POST http://localhost:8000/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": "test"' | jq
```

### 🔧 Hardware Requirements

This project supports both **GPU** and **CPU-only** environments.

#### Recommended (GPU Setup)
- NVIDIA GPU with **8GB+ VRAM** for fast inference
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) installed
- Docker with GPU support (`nvidia-docker`)
- At least **8GB RAM**

#### Minimum (CPU-only Setup)
- CPU with **AVX support** (most modern Intel/AMD processors)
- At least **8GB RAM**
- Works for inference, but **fine-tuning is not recommended** on CPU due to long runtimes

> ⚠️ Note: If you are using a CPU-only machine, stick to inference with the pretrained or fine-tuned model. Avoid training unless you know what you're doing and have lots of patience.