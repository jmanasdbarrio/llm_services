#!/bin/sh
MODEL_PATH='/default-comfyui-bundle/ComfyUI/models/checkpoints/juggernautXL_juggXIByRundiffusion.safetensors'

if [ ! -f "$MODEL_PATH" ]; then
  echo 'Downloading model...'
  mkdir -p /default-comfyui-bundle/ComfyUI/models/checkpoints
  wget -q --show-progress \
    --header="Authorization: Bearer $CIVITAI_API_KEY" \
    'https://civitai.com/api/download/models/1759168?type=Model&format=SafeTensor&size=full&fp=fp16' \
    -O "$MODEL_PATH"
  echo 'Model downloaded.'
else
  echo 'Model already exists, skipping download.'
fi

python3 /default-comfyui-bundle/ComfyUI/main.py --listen 0.0.0.0 --port 8188