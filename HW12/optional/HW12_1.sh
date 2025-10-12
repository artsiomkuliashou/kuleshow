#!/bin/bash

# Функция для обхода каталога
scan_directory() {
    local dir="$1"
    
    # Проверка возможности чтения каталога
    if [ ! -r "$dir" ]; then
        echo "Предупреждение: Нет доступа к каталогу '$dir'"
        return
    fi
    
        # Проверка возможности выполнения каталога (необходимо для доступа к содержимому)
    if [ ! -x "$dir" ]; then
        echo "Предупреждение: Нет прав на выполнение каталога '$dir' (невозможно прочитать содержимое)"
        return
    fi
    
    # Обход элементов в каталоге
    for item in "$dir"/*; do
        if [ -f "$item" ]; then
            # Если это файл - выводим информацию
            size=$(stat -c%s "$item" 2>/dev/null || echo "N/A")
            permissions=$(stat -c%A "$item" 2>/dev/null || echo "N/A")
            
            echo "Файл: $item"
            echo "  Размер: $size байт"
            echo "  Права доступа: $permissions"
            echo "---"
        elif [ -d "$item" ]; then
            # Если это каталог - рекурсивно обходим его
            scan_directory "$item"
        fi
    done
}

# Проверка наличия аргумента
if [ $# -eq 0 ]; then
    echo "Ошибка: Не указан каталог"
    echo "Использование: $0 <каталог>"
    exit 1
fi

directory="$1"

# Проверка существования каталога
if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог '$directory' не существует"
    exit 1
fi

# Запуск сканирования
scan_directory "$directory"