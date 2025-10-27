#!/bin/bash

# Функция для добавления timestamp к .log файлам
rename_log_files() {
    for file in *.log; do
        if [ -f "$file" ]; then
            # Получаем timestamp в формате YYYYMMDD_HHMMSS
            timestamp=$(date +%Y%m%d_%H%M%S)
            # Убираем расширение .log из имени файла
            basename="${file%.log}"
            # Переименовываем файл
            mv "$file" "${basename}_${timestamp}.log"
            echo "Переименован: $file -> ${basename}_${timestamp}.log"
        fi
    done
}

# Функция для добавления хэша коммита к .py файлам
rename_py_files() {
    # Проверяем, что это git репозиторий
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Ошибка: Это не git репозиторий"
        return 1
    fi
    
    # Получаем короткий хэш коммита
    commit_hash=$(git rev-parse --short HEAD)
    
    for file in *.py; do
        if [ -f "$file" ]; then
            # Убираем расширение .py из имени файла
            basename="${file%.py}"
            # Переименовываем файл
            mv "$file" "${basename}_${commit_hash}.py"
            echo "Переименован: $file -> ${basename}_${commit_hash}.py"
        fi
    done
}

# Основная логика скрипта
main() {
    echo "Начало обработки файлов..."
    
    # Обрабатываем .log файлы
    if ls *.log > /dev/null 2>&1; then
        echo "Обработка .log файлов:"
        rename_log_files
    else
        echo "Файлы .log не найдены"
    fi
    
    echo "---"
    
    # Обрабатываем .py файлы
    if ls *.py > /dev/null 2>&1; then
        echo "Обработка .py файлов:"
        rename_py_files
    else
        echo "Файлы .py не найдены"
    fi
    
    echo "Обработка завершена!"
}

# Запускаем основную функцию
main