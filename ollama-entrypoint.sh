#!/bin/sh
ollama serve &
sleep 5

ollama pull qwen3.5:9b
printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf
# printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 262144\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf  # 262144 context length would require more than 24GB VRAM

ollama pull qwen2.5-coder:7b
printf 'FROM qwen2.5-coder:7b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create qwen2.5-coder:7b -f /tmp/mf

ollama pull gemma4:e4b
printf 'FROM gemma4:e4b\nPARAMETER num_ctx 16384\n' > /tmp/mf && ollama create gemma4:e4b -f /tmp/mf

ollama pull nomic-embed-text:v1.5

wait
