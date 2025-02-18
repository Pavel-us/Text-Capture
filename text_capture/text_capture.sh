#!/bin/bash

# -------------------------  Text Capture  -----------------------------
# скрипт для распознавание текста и QR-кодов.
# писал на коленки для собственных нужд, для linux mint 22 Cinnamon
# установка:
# файл text_capture.desktop закинуть в директорию /local/share/applications/
# в файде text_capture.desktop указать пути для text_capture.sh и иконки
# Exec=/home/user/text_capture/text_capture.sh
# Icon=/home/user/text_capture/text_capture.png
# сделайте файл исполняемым:
# chmod +x ~/.local/share/applications/text_capture.desktop
# так же файл text_capture.sh сделайте исполняемым:
# chmod +x text_capture.sh
# 
# добавте пакеты.
# Необходимые пакеты:
# tesseract-ocr — для распознавания текста.
# scrot — для захвата скриншотов.
# xclip — для работы с буфером обмена.
# notify-osd — для отображения уведомлений.
# zbar-tools — для распознавания QR-кодов.
# команды для установки:
# sudo apt install tesseract-ocr scrot xclip notify-osd zbar-tools
# 
# добавить поддержку разных языков в Tesseract,
# установив соответствующие языковые пакеты, например:
# sudo apt install tesseract-ocr-rus tesseract-ocr-eng
# 
# В функции для захвата текста укажите языки например:
# LANGUAGES="rus+eng"
# 
# После установки перезагрузите Cinnamon
# нажмите Alt + F2, введите r и нажмите Enter
# программа отобразиться в меню
# 
# https://github.com/Pavel-us
# ----------------------------------------------------------------------

# Функция для уведомлений
function notify() {
    local TITLE="$1"
    local MESSAGE="$2"
    notify-send "$TITLE" "$MESSAGE"
}

# Функция для захвата текста
function capture_text() {
    # Основной язык - русский английский
    LANGUAGES="rus+eng"

    # Временный файл для хранения скриншота
    TEMP_FILE=$(mktemp).png

    # Захват области экрана
    scrot -s "$TEMP_FILE" || { notify "Ошибка" "Не удалось захватить экран."; exit 1; }

    # Распознавание текста с изображения
    TEXT=$(tesseract -l "$LANGUAGES" "$TEMP_FILE" stdout 2>/dev/null) || { notify "Ошибка" "Не удалось распознать текст."; exit 1; }

    # Копирование текста в буфер обмена
    echo -n "$TEXT" | xclip -selection clipboard

    # Уведомление о завершении
    notify "Текст скопирован в буфер обмена" "$TEXT"

    # Удаление временного файла
    rm "$TEMP_FILE"
}

# Функция для захвата QR-кода
function capture_qr() {
    # Проверка наличия zbar-tools
    if ! command -v zbarimg &> /dev/null; then
        zenity --question --title="Установка zbar-tools" \
            --text="Для распознавания QR-кодов требуется установить zbar-tools. Хотите установить?" \
            --ok-label="Установить" --cancel-label="Отмена"
        if [ $? -eq 0 ]; then
            # Открываем терминал для установки
            gnome-terminal -- bash -c "sudo apt update && sudo apt install zbar-tools; echo 'Нажмите Enter для выхода...'; read"
        else
            exit 1
        fi
    fi

    # Временный файл для хранения скриншота
    TEMP_FILE=$(mktemp).png

    # Захват области экрана
    scrot -s "$TEMP_FILE" || { notify "Ошибка" "Не удалось захватить экран."; exit 1; }

    # Распознавание QR-кода
    QR_TEXT=$(zbarimg -q "$TEMP_FILE" | sed 's/^QR-Code://') || { notify "Ошибка" "Не удалось распознать QR-код."; exit 1; }

    # Проверка результата распознавания
    if [ -z "$QR_TEXT" ]; then
        notify "Ошибка" "QR-код не распознан или пуст."
        rm "$TEMP_FILE"
        exit 1
    fi

    # Копирование текста в буфер обмена
    echo -n "$QR_TEXT" | xclip -selection clipboard

    # Уведомление о завершении
    notify "QR-код распознан" "$QR_TEXT"

    # Удаление временного файла
    rm "$TEMP_FILE"
}

# Панель для выбора действия
function show_panel() {
    CHOICE=$(zenity --list --title="Text Capture" \
        --text="Выберите действие:" \
        --column="Действие" "Захват текста" "Захват QR-кода" "Выход" \
        --width=300 --height=200)

    case "$CHOICE" in
        "Захват текста")
            capture_text
            ;;
        "Захват QR-кода")
            capture_qr
            ;;
        "Выход")
            exit 0
            ;;
        *)
            exit 0
            ;;
    esac
}

# Показать панель при запуске
show_panel
