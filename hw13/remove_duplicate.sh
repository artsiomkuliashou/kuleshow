#!/bin/bash

if [ $# -eq 0 ]; then
    # Чтение из stdin
    sed -E 's/\b([[:alpha:]]+)\b[[:space:]]+\b\1\b/\1/g'
else
    # Обработка файлов
    for file in "$@"; do
        sed -E 's/\b([[:alpha:]]+)\b[[:space:]]+\b\1\b/\1/g' "$file"
    done
fi