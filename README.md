# LLM Fine-tuning

This project is a solution for the **LLM Fine-tuning Project**, demonstrating practical skills in Large Language Model fine-tuning and deployment.

## 📖 Overview

This repository contains code and documentation for:
- Exploring and preprocessing the [`yahma/alpaca-cleaned`](https://huggingface.co/datasets/yahma/alpaca-cleaned) dataset.
- Setting up and running the [`Qwen/Qwen3-0.6B`](https://huggingface.co/Qwen/Qwen3-0.6B) LLM.
- Formatting data for instruction fine-tuning (Alpaca prompt style).
- (Milestone 2) Fine-tuning the LLM with LoRA/QLoRA.
- (Milestone 3) Deploying the fine-tuned model as a REST API in Docker.


## 🚀 Startup

1. Clone repo:

```bash
git clone --single-branch --branch development git@github.com:andmanousakis/LLM-Fine-Tuning.git
```

2. Navigate to the direcotry:

```bash
cd LLM-Fine-Tuning
```

3. Install dependencies with **Conda** using the provided `Makefile`:

```bash
make conda
```

3. Activate conda env:

```bash
conda activate llm-assessment
```