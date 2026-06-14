# =============================================================================
# video-parsing Multi-Tag Dockerfile
#
# GGUF inference:  CUDA + Vulkan backends (auto-selected by ggml loader)
# ONNX inference:  vendor-specific per tag
#
# Build:
#   docker build --target nvidia -t video-parsing:nvidia .
#   docker build --target cpu    -t video-parsing:cpu .
#   docker build --target amd    -t video-parsing:amd .
#   docker build --target intel  -t video-parsing:intel .
#
# Run:
#   NVIDIA:  docker run --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all video-parsing:nvidia ...
#   CPU:     docker run video-parsing:cpu ...
#   AMD:     docker run --device /dev/kfd --device /dev/dri video-parsing:amd ...
#   Intel:   docker run --device /dev/dri video-parsing:intel ...
# =============================================================================

# --- Shared Base: app code + Vulkan llama.cpp + system deps ---
FROM python:3.12-slim AS base

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgomp1 ffmpeg libvulkan1 && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    -r /tmp/requirements.txt

COPY . /app
WORKDIR /app

RUN cp /app/bin-vulkan/libggml-vulkan.so* /app/bin/ && \
    cd /bin && for f in /app/bin/lib*.so; do ln -sf "$f" "$(basename $f)"; done

ENV LD_LIBRARY_PATH=/app/bin
ENV PYTHONPATH=/app
ENTRYPOINT ["python", "main.py"]
CMD ["--help"]

# ============================================================================
# :nvidia — CUDA ONNX + CUDA/Vulkan GGUF
# ============================================================================
FROM python:3.12-slim AS cuda-strip
RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    nvidia-cuda-runtime-cu12 nvidia-cublas-cu12 nvidia-nccl-cu12 \
    nvidia-curand-cu12 nvidia-cufft-cu12 nvidia-cudnn-cu12
RUN mkdir -p /cuda-libs && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cuda_runtime/lib/*.so* /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cublas/lib/*.so* /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/nccl/lib/*.so* /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/curand/lib/*.so* /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cufft/lib/*.so* /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_graph.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_ops.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_cnn.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_heuristic.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_engines_precompiled.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_engines_runtime_compiled.so.9 /cuda-libs/ && \
    cp /usr/local/lib/python3.12/site-packages/nvidia/cudnn/lib/libcudnn_engines_tensor_ir.so.9 /cuda-libs/

FROM base AS nvidia
RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    onnxruntime-gpu>=1.17
COPY --from=cuda-strip /cuda-libs/ /usr/local/cuda/lib64/
ENV LD_LIBRARY_PATH=/app/bin:/usr/local/cuda/lib64

# ============================================================================
# :cpu — CPU ONNX + Vulkan GGUF (fallback to CPU without GPU)
# ============================================================================
FROM base AS cpu
RUN pip install --no-cache-dir onnxruntime>=1.17

# ============================================================================
# :amd — CPU ONNX + Vulkan GGUF (MIGraphX EP requires source build)
# ============================================================================
FROM base AS amd
RUN pip install --no-cache-dir onnxruntime>=1.17

# ============================================================================
# :intel — OpenVINO ONNX + Vulkan GGUF
# ============================================================================
FROM base AS intel
RUN pip install --no-cache-dir onnxruntime-openvino>=1.17
