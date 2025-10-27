#!/bin/bash

# Функция проверки валидности email
is_valid_email() {
    local email="$1"
    
    # Проверяем наличие только одной @
    if [[ $(echo "$email" | tr -cd '@' | wc -c) -ne 1 ]]; then
        return 1
    fi
    
    # Разделяем на local-part и domain-part
    local local_part="${email%@*}"
    local domain_part="${email#*@}"
    
    # Проверяем длину
    if [[ ${#local_part} -gt 64 || ${#domain_part} -gt 255 ]]; then
        return 1
    fi
    
    # Проверяем local-part: не начинается и не заканчивается на .+-
    if [[ "$local_part" =~ ^[.+-] || "$local_part" =~ [.+-]$ ]]; then
        return 1
    fi
    
    # Проверяем domain-part: не начинается и не заканчивается на -
    if [[ "$domain_part" =~ ^- || "$domain_part" =~ -$ ]]; then
        return 1
    fi
    
    # Проверяем на две точки подряд
    if [[ "$local_part" == *..* || "$domain_part" == *..* ]]; then
        return 1
    fi
    
    # Проверяем символы в local-part (только латинские буквы, цифры и '._+-')
    if [[ ! "$local_part" =~ ^[a-zA-Z0-9._+-]+$ ]]; then
        return 1
    fi
    
    # Проверяем символы в domain-part (только латинские буквы, цифры и '-.')
    if [[ ! "$domain_part" =~ ^[a-zA-Z0-9.-]+$ ]]; then
        return 1
    fi
    
    # Домен должен содержать хотя бы одну точку
    if [[ ! "$domain_part" == *.* ]]; then
        return 1
    fi
    
    return 0
}

# Переменные для параметров
output_file=""
input_source=""

# Разбор параметров командной строки
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--file)
            output_file="$2"
            shift 2
            ;;
        *)
            input_source="$1"
            shift
            ;;
    esac
done

# Основная программа
if [[ -z "$input_source" ]]; then
    # Читаем из stdin
    text=$(cat)
else
    # Читаем из файла
    text=$(cat "$input_source")
fi

# Временный файл для уникальных адресов
temp_file=$(mktemp)

# Ищем кандидатов с помощью grep (упрощенная регулярка)
echo "$text" | grep -o -E '[a-zA-Z0-9._+%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+' | while read -r candidate; do
    # Убираем возможные trailing точки/минусы в домене
    candidate=$(echo "$candidate" | sed 's/[.-]*$//')
    
    if is_valid_email "$candidate"; then
        echo "$candidate" >> "$temp_file"
    fi
done

# Сортируем и удаляем дубликаты
sorted_emails=$(sort -u "$temp_file")

# Выводим результат
if [[ -n "$output_file" ]]; then
    # Записываем в файл
    echo "$sorted_emails" > "$output_file"
    echo "Email адреса сохранены в файл: $output_file"
else
    # Выводим на экран
    echo "$sorted_emails"
fi

# Удаляем временный файл
rm -f "$temp_file"