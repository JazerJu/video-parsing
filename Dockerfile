FROM python:3.12-slim

# ── System dependencies ──────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg libgomp1 gcc && \
    rm -rf /var/lib/apt/lists/*

# ── Python dependencies ──────────────────────────────────
# Use Chinese mirror for speed
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    -r /tmp/requirements.txt && \
    pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    nvidia-cuda-runtime-cu12 nvidia-cublas-cu12 nvidia-cudnn-cu12

# ── Application ──────────────────────────────────────────
COPY . /app
WORKDIR /app

# NVIDIA lib paths for llama.cpp ctypes + onnxruntime-gpu
ENV LD_LIBRARY_PATH=/app/bin:\
/usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib:\
/usr/local/lib/python3.12/site-packages/nvidia/cublas/lib:\
/usr/local/lib/python3.12/site-packages/nvidia/cuda_runtime/lib
ENV PYTHONPATH=/app

ENTRYPOINT ["python", "main.py"]
CMD ["--help"]
