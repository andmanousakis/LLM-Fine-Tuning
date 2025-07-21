# File: docker/Dockerfile.gpu

# ---------- Stage 1: Builder ----------
FROM nvidia/cuda:12.3.0-runtime-ubuntu22.04 AS builder

WORKDIR /app

# Install only what is needed for build.
RUN apt-get update && \
    apt-get install -y python3-pip gcc curl && \
    rm -rf /var/lib/apt/lists/*

# Install pip first, then dependencies (for better cache).
RUN pip3 install --upgrade pip

COPY requirements.txt .
RUN pip3 install --upgrade pip && pip3 install --user -r requirements.txt

# Copy only code and adapters needed for runtime.
COPY milestone3_api/main.py .
COPY adapters/finetuned-qwen-lora/ ./adapters/

# ---------- Stage 2: Final image ----------
FROM nvidia/cuda:12.3.0-runtime-ubuntu22.04

WORKDIR /app

# System deps ONLY needed for runtime.
RUN apt-get update && \
    apt-get install -y python3-pip curl && \
    rm -rf /var/lib/apt/lists/*

# Copy installed packages and app code from builder.
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

ENV PATH=/root/.local/bin:$PATH

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl --fail http://localhost:8000/health || exit 1

ENTRYPOINT ["uvicorn"]
CMD ["main:app", "--host", "0.0.0.0", "--port", "8000"]
