#!/bin/sh
ollama serve &
sleep 5

ensure_model() {
	if ! ollama list | awk 'NR > 1 {print $1}' | grep -Fqx "$1"; then
		ollama pull "$1"
	fi
}

ensure_model qwen3.5:9b
# printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf
printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 65536\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf
# printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 131072\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf
# printf 'FROM qwen3.5:9b\nPARAMETER num_ctx 262144\n' > /tmp/mf && ollama create qwen3.5:9b -f /tmp/mf  # 262144 context length would require more than 24GB VRAM

ensure_model qwen2.5-coder:14b
printf 'FROM qwen2.5-coder:14b\nPARAMETER num_ctx 24576\n' > /tmp/mf && ollama create qwen2.5-coder:14b -f /tmp/mf
# printf 'FROM qwen2.5-coder:14b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create qwen2.5-coder:14b -f /tmp/mf

ensure_model gemma4:e4b
# printf 'FROM gemma4:e4b\nPARAMETER num_ctx 16384\n' > /tmp/mf && ollama create gemma4:e4b -f /tmp/mf
printf 'FROM gemma4:e4b\nPARAMETER num_ctx 32768\n' > /tmp/mf && ollama create gemma4:e4b -f /tmp/mf
printf 'FROM gemma4:e4b\nPARAMETER num_ctx 16384\nPARAMETER num_thread 8\n' > /tmp/mf && ollama create gemma4:e4b-rag -f /tmp/mf

ensure_model nomic-embed-text:v1.5

wait
