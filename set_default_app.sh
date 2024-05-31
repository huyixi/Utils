#!/bin/bash

# 确保 duti 已安装
if ! command -v duti &> /dev/null; then
  echo "duti 未安装。请先安装 duti。"
  exit 1
fi

# 获取应用程序的 Bundle Identifier
get_bundle_id() {
  app_name="$1"
  osascript -e "id of app \"$app_name\""
}

# 获取常见应用程序的 Bundle Identifier
apple_books_id=$(get_bundle_id "Books")
preview_id=$(get_bundle_id "Preview")
safari_id=$(get_bundle_id "Safari")
vscode_id=$(get_bundle_id "Visual Studio Code")
vlc_id=$(get_bundle_id "VLC")
chrome_id=$(get_bundle_id "Google Chrome")
textedit_id=$(get_bundle_id "TextEdit")
excel_id=$(get_bundle_id "Microsoft Excel")
word_id=$(get_bundle_id "Microsoft Word")

# 定义文件类型和对应的应用程序
declare -A file_types
file_types=(
  ["com.adobe.pdf"]=$apple_books_id
  ["public.jpeg"]=$preview_id
  ["public.png"]=$preview_id
  ["public.html"]=$safari_id
  ["public.plain-text"]=$vscode_id
  ["public.python-script"]=$vscode_id
  ["public.mpeg-4"]=$vlc_id
  ["public.mp3"]=$vlc_id
  ["public.zip-archive"]=$preview_id
  ["com.microsoft.word.doc"]=$word_id
  ["com.microsoft.excel.xls"]=$excel_id
  ["com.microsoft.excel.xlsx"]=$excel_id
  ["com.microsoft.powerpoint.ppt"]=$powerpoint_id
  ["com.microsoft.powerpoint.pptx"]=$powerpoint_id
  ["public.csv"]=$excel_id
  ["com.apple.keynote.key"]=$keynote_id
  ["com.apple.pages.pages"]=$pages_id
  ["com.apple.numbers.numbers"]=$numbers_id
)

# 设置默认应用程序
for file_type in "${!file_types[@]}"; do
  duti -s "${file_types[$file_type]}" "$file_type" all
done

echo "已成功设置默认应用程序。"
