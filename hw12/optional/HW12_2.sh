#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 <строка_для_поиска> <каталог>"
    exit 1
fi

search_string="$1"
directory="$2"

# Проверка существования каталога
if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог '$directory' не существует"
    exit 1
fi

echo "Поиск строки '$search_string' в каталоге '$directory' и его подкаталогах"
echo "======================================================================"

# Рекурсивный поиск с обработкой ошибок доступа
find "$directory" -type f 2>/dev/null | while read -r file; do
    # Проверяем, доступен ли файл для чтения
    if [ -r "$file" ]; then
        # Ищем строку в файле
        if grep -q "$search_string" "$file" 2>/dev/null; then
            # Получаем размер файла
            size=$(stat -c%s "$file" 2>/dev/null || echo "N/A")
            echo "Файл: $file"
            echo "Размер: $size байт"
            echo "---"
        fi
    fi
done

# Обработка ошибок доступа к каталогам
find "$directory" -type d 2>&1 | grep "Permission denied" | while read -r error; do
    echo "ОШИБКА ДОСТУПА: $error"
done

echo "Поиск завершен"