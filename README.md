
 script for text and QR code recognition.
 wrote it on my knees for my own needs, for Linux Mint 22 Cinnamon
 installation:
 drop the text_capture.desktop file into the /local/share/applications/ directory
 in the text_capture.desktop file specify the paths for text_capture.sh and the icon
 Exec=/home/user/text_capture/text_capture.sh
 Icon=/home/user/text_capture/text_capture.png
 make the file executable:
 chmod +x ~/.local/share/applications/text_capture.desktop
 also make the text_capture.sh file executable:
 chmod +x text_capture.sh
#
 add packages.
 Required packages:
 tesseract-ocr — for text recognition.
 scrot — for screenshot capture.
 xclip — for working with the clipboard.
 notify-osd — for displaying notifications.
 zbar-tools — for recognizing QR codes.
 installation commands:
 sudo apt install tesseract-ocr scrot xclip notify-osd zbar-tools
#
 add support for different languages ​​to Tesseract,
 by installing the corresponding language packs, for example:
 sudo apt install tesseract-ocr-rus tesseract-ocr-eng
#
 In the text capture function, specify the languages, for example:
 LANGUAGES="rus+eng"
#
 After installation, restart Cinnamon
 press Alt + F2, type r and press Enter
 the program will appear in the menu

 скрипт для распознавание текста и QR-кодов.
 писал на коленки для собственных нужд, для linux mint 22 Cinnamon
 установка:
 файл text_capture.desktop закинуть в директорию /local/share/applications/
 в файде text_capture.desktop указать пути для text_capture.sh и иконки
 Exec=/home/user/text_capture/text_capture.sh
 Icon=/home/user/text_capture/text_capture.png
 сделайте файл исполняемым:
 chmod +x ~/.local/share/applications/text_capture.desktop
 так же файл text_capture.sh сделайте исполняемым:
 chmod +x text_capture.sh
# 
 добавте пакеты.
 Необходимые пакеты:
 tesseract-ocr — для распознавания текста.
 scrot — для захвата скриншотов.
 xclip — для работы с буфером обмена.
 notify-osd — для отображения уведомлений.
 zbar-tools — для распознавания QR-кодов.
 команды для установки:
 sudo apt install tesseract-ocr scrot xclip notify-osd zbar-tools
# 
 добавить поддержку разных языков в Tesseract,
 установив соответствующие языковые пакеты, например:
 sudo apt install tesseract-ocr-rus tesseract-ocr-eng
# 
 В функции для захвата текста укажите языки например:
 LANGUAGES="rus+eng"
# 
 После установки перезагрузите Cinnamon
 нажмите Alt + F2, введите r и нажмите Enter
 программа отобразиться в меню
