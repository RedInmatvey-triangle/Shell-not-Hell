#!/bin/bash

# Обновляем индекс пакетов
sudo apt update

# Устанавливаем python3 и pip (если не установлены)
if ! command -v python3 &> /dev/null; then
    echo "Устанавливаю Python3..."
    sudo apt install -y python3
else
    echo "Python3 уже установлен."
fi

if ! command -v pip3 &> /dev/null; then
    echo "Устанавливаю pip3..."
    sudo apt install -y python3-pip
else
    echo "pip3 уже установлен."
fi

# Устанавливаем requests через pip3
pip3 show requests &> /dev/null
if [ $? -ne 0 ]; then
    echo "Устанавливаю Python пакет requests..."
    pip3 install requests --user
else
    echo "Python пакет requests уже установлен."
fi

# Устанавливаем Ollama, если не установлен
if ! command -v ollama &> /dev/null; then
    echo "Устанавливаю Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "Ollama уже установлен."
fi

# Запускаем Ollama сервер в фоновом режиме
echo "Запускаю Ollama сервер..."
ollama serve &

# Ждем 3 секунды для старта сервера
sleep 3

# Загружаем модель qwen2.5-coder:3b
echo "Загружаю модель qwen2.5-coder:3b..."
ollama pull qwen2.5-coder:3b

echo "Установка и настройка завершены."
echo "Теперь можно запускать Shell Not Hell."
# Copyright 2025 Redin Matvey <redinmatvey11@gmail.com>
# Licensed under GNU GPLv3 license.
