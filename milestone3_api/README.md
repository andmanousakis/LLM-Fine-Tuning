## 🛸 Milestone 3 Documentation

**API usage examples:**

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