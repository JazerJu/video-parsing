# Video-Parsing

视频理解框架 — 离线 GGUF+ONNX 混合推理 + 外部 LLM 增强摘要。

## 架构

- **视觉编码器**: MiniCPM-V 4.5/4.6 (SigLIP ONNX + Resampler ONNX)
- **LLM 解码器**: MiniCPM-V GGUF (llama.cpp ctypes 绑定, CUDA 加速)
- **Embedding**: BGE-small-zh-v1.5 (ONNX Runtime)
- **OCR**: GLM-OCR (llama.cpp ctypes, 可选)
- **外部 API**: Gemini / DeepSeek / Doubao / StepFun / MiMo (用于摘要和知识查询)

无 PyTorch 依赖。纯 numpy + PIL + ONNX Runtime + ctypes。

## 前置条件

### 模型文件 (需自行下载)

```
models/
├── MiniCPM-V-4_5-Q4_K_M.gguf          # MiniCPM-V 4.5 GGUF
├── MiniCPM-V-4_6-Q4_K_M.gguf          # MiniCPM-V 4.6 GGUF (可选)
├── GLM-OCR-Q8_0.gguf                   # GLM-OCR GGUF (可选, extract 命令需要)
└── bge-small-zh-v1.5-onnx/             # BGE Embedding (已包含)

onnx/
├── minicpmv_v45_siglip.fp32.onnx       # SigLIP 视觉编码器
└── minicpmv_v45_resampler_temporal.fp16.onnx  # 时序重采样器
```

### llama.cpp 共享库

`bin/` 目录需要 llama.cpp 编译产物:

```bash
# 从本地 llama.cpp 构建复制
cp /path/to/llama.cpp/build/bin/libggml.so.0 bin/
cp /path/to/llama.cpp/build/bin/libggml-base.so.0 bin/
cp /path/to/llama.cpp/build/bin/libggml-cpu.so.0 bin/
cp /path/to/llama.cpp/build/bin/libggml-cuda.so.0 bin/
cp /path/to/llama.cpp/build/bin/libllama.so.0 bin/

# 创建符号链接
cd bin
ln -sf libggml.so.0 libggml.so
ln -sf libggml-base.so.0 libggml-base.so
ln -sf libggml-cpu.so.0 libggml-cpu.so
ln -sf libggml-cuda.so.0 libggml-cuda.so
ln -sf libllama.so.0 libllama.so
```

## Docker

### 构建

```bash
docker build -t video-parsing .
```

### 运行

```bash
docker run --gpus all \
  -v /path/to/models:/app/models \
  -v /path/to/onnx:/app/onnx \
  -v /path/to/video.mp4:/data/video.mp4 \
  -v /path/to/video.srt:/data/video.srt \
  --env-file .env \
  video-parsing \
  build --frames low
```

## 命令

| 命令 | 说明 |
|------|------|
| `build` | 构建视频数据库 (离线 GGUF+ONNX 推理) |
| `summarize` | 生成视频摘要 (外部 LLM) |
| `ask` | 多轮对话 |
| `inspect` | 时间段视觉 VQA |
| `external` | 外部知识查询 |
| `extract` | 提取幻灯片+代码+终端 (GLM-OCR) |

## 配置

所有配置通过环境变量或 `.env` 文件:

```bash
cp .env.example .env
# 编辑 API keys 和路径
```

## 许可证

MIT
