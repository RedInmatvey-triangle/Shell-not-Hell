#!/bin/bash

SRC_FILE="snh.py"
DEST_DIR="/bin"
DEST_FILE="snh"

if [ ! -f "$SRC_FILE" ]; then
    echo "Исходный файл $SRC_FILE не найден!"
    exit 1
fi

# Копируем и переименовываем
echo "Копирую $SRC_FILE в $DEST_DIR/$DEST_FILE ..."
sudo cp "$SRC_FILE" "$DEST_DIR/$DEST_FILE"

# Делаем исполняемым
sudo chmod +x "$DEST_DIR/$DEST_FILE"

echo "Готово. Для запуска введите команду:"
echo "  $DEST_FILE"
echo "Запущено от пользователя: $USER"

cat << EOF >> .bashrc
sudo systemctl stop ollama
sudo systemctl start ollama
ollama pull qwen2.5-coder:3b
EOF
echo "Готово."
