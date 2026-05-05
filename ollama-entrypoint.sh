#!/bin/sh
ollama serve &
sleep 5

ollama pull qwen3.5:9b
printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf

ollama pull gemma4:e4b
printf 'FROM gemma4:e4b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create gemma4:e4b -f /tmp/mf

ollama pull nomic-embed-text:v1.5

wait
