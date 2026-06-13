FROM python:3.12-slim AS cuda-strip
RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    nvidia-cuda-runtime-cu12 nvidia-cublas-cu12

FROM python:3.12-slim
RUN sed -i 's|deb.debian.org|mirrors.tuna.tsinghua.edu.cn|g' \
    /etc/apt/sources.list.d/debian.sources 2>/dev/null || true && \
    apt-get update && apt-get install -y --no-install-recommends libgomp1 && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir \
    -i https://pypi.tuna.tsinghua.edu.cn/simple/ \
    -r /tmp/requirements.txt

COPY --from=cuda-strip \
    /usr/local/lib/python3.12/site-packages/nvidia/cuda_runtime/lib/ \
    /usr/local/cuda/lib64/
COPY --from=cuda-strip \
    /usr/local/lib/python3.12/site-packages/nvidia/cublas/lib/ \
    /usr/local/cuda/lib64/

COPY . /app
WORKDIR /app

ENV LD_LIBRARY_PATH=/app/bin:/usr/local/cuda/lib64
ENV PYTHONPATH=/app

ENTRYPOINT ["python", "main.py"]
CMD ["--help"]
