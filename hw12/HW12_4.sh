#!/bin/bash

# Проверка на количество аргументов
if [ $# -ne 3 ]; then
    echo "Ошибка: Не переданы аргументы командной строки или аргументов не 3"
    echo "Использование: $0 <файл вывода> <путь к папке> <расширение>"
    exit 1
fi

# Если проверка пройдена, можно использовать аргументы
output_file="$1"
folder_path="$2"
extension="$3"

# Проверка что каталог существует
if [ ! -d "$folder_path" ]; then
    echo "Ошибка: Каталог '$folder_path' не существует"
    exit 1
fi

# Проверка что каталог читаем
if [ ! -r "$folder_path" ]; then
    echo "Ошибка: Каталог '$folder_path' недоступен для чтения"
    exit 1
fi

# Проверка что есть файлы с указанным расширением
if ! find "$folder_path" -maxdepth 1 -type f -name "*.$extension" | grep -q .; then
    echo "Ошибка: В каталоге '$folder_path' не найдено файлов с расширением '.$extension'"
    exit 1
fi

# Проверка что файл вывода можно создать
if ! touch "$output_file" 2>/dev/null; then
    echo "Ошибка: Не удается создать файл '$output_file'" >&2
    echo "Проверьте права доступа к каталогу" >&2
    exit 1
fi

# Проверка что в файл можно писать если он уже есть
if [ ! -w "$output_file" ]; then
    echo "Ошибка: Нет прав на запись в файл '$output_file'" >&2
    exit 1
fi

# Записываем имена файлов с заданным расширением в файл
find "$folder_path" -maxdepth 1 -type f -name "*.$extension" -printf "%f\n" | sort > "$output_file"
echo "успешно: данные записаны в $output_file"