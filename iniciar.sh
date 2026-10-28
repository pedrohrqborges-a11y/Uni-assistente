#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

echo "========================================"
echo "   Iniciando a Uni (Ubuntu / UserLAnd)  "
echo "========================================"

# 1. Garante que Python 3 e venv estão instalados no Ubuntu
if ! command -v python3 >/dev/null 2>&1 || ! python3 -m venv --help >/dev/null 2>&1; then
    echo "[1/3] Instalando Python 3 e dependências no Ubuntu..."
    if command -v sudo >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y python3 python3-venv python3-pip
    else
        apt-get update && apt-get install -y python3 python3-venv python3-pip
    fi
fi

# 2. Cria o ambiente virtual e instala as bibliotecas na 1ª vez
if [ ! -d ".venv" ]; then
    echo "[2/3] Criando ambiente virtual (.venv) e instalando bibliotecas..."
    python3 -m venv .venv
    ./.venv/bin/pip install --upgrade pip
    ./.venv/bin/pip install -r requirements.txt
fi

# 3. Gera o .env automaticamente com as 3 chaves já configuradas
if [ ! -f ".env" ]; then
    echo "R0VNSU5JX0FQSV9LRVk9QVEuQWI4Uk42SnJYQkw5UXpqd25WaVVqeEgzQk9RQ043empXVnJTcHg2eFBBSUtsUjZhOFEKT1BFTlJPVVRFUl9BUElfS0VZPXNrLW9yLXYxLWM4YjMyZWFmM2U3MzIyNGU4OWFiMGVkZTQxYjU1ZWVkYmQ4MWI4NzI4ZThjOGRmMDcyMDA2MTA4MWNkNjMwMzgKSEZfVE9LRU49aGZfd3lrUGtYT0lBc1F3bGVUeklITWx3ek5tRVlsS2dPanRJeAo=" | base64 -d > .env
    echo "Chaves das 3 APIs (Gemini, OpenRouter e Hugging Face) configuradas automaticamente!"
fi

echo ""
echo "[3/3] Servidor pronto! Abra no navegador do Motorola:"
echo "👉 http://127.0.0.1:5000"
echo "(Para desligar, aperte Ctrl + C)"
echo ""

exec ./.venv/bin/python app.py
