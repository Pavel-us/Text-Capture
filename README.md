# Text-Capture
 **script for text and QR code recognition.**
 ### installation:
 drop the `text_capture.desktop` file into the `/local/share/applications/` directory
 in the `text_capture.desktop` file specify the paths for text_capture.sh and the icon
 Exec=`/home/user/text_capture/text_capture.sh`
 Icon=`/home/user/text_capture/text_capture.png`
 make the file executable:
```bash 
chmod +x ~/.local/share/applications/text_capture.desktop
```
 also make the text_capture.sh file executable:
```bash 
chmod +x text_capture.sh
```
#
 ### add packages.
 Required packages:
+ tesseract-ocr — for text recognition.
+ scrot — for screenshot capture.
+ xclip — for working with the clipboard.
+ notify-osd — for displaying notifications.
+ zbar-tools — for recognizing QR codes.
 installation commands:
 ```bash
sudo apt install tesseract-ocr scrot xclip notify-osd zbar-tools
```
#
 ### add support for different languages ​​to Tesseract,
 by installing the corresponding language packs, for example:
```bash
sudo apt install tesseract-ocr-rus tesseract-ocr-eng
```
#
 In the text capture function, specify the languages, for example:
```bash
LANGUAGES="rus+eng"
```
