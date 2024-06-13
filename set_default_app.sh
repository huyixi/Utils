#!/bin/bash

# 检查 duti 是否安装
if ! command -v duti &> /dev/null; then
    echo "duti 未安装。请先安装 duti。"
    exit 1
fi

# 设置图片文件的默认应用为 qView
duti -s com.interversehq.qView jpg all
duti -s com.interversehq.qView jpeg all
duti -s com.interversehq.qView png all
duti -s com.interversehq.qView gif all
duti -s com.interversehq.qView tiff all
duti -s com.interversehq.qView bmp all
duti -s com.interversehq.qView heic all

# 设置视频文件的默认应用为 IINA
duti -s com.colliderli.iina mov all
duti -s com.colliderli.iina mp4 all
duti -s com.colliderli.iina avi all
duti -s com.colliderli.iina mkv all
duti -s com.colliderli.iina m4v all

# 文本类型使用 Visual Studio Code
duti -s com.microsoft.VSCode txt all
duti -s com.microsoft.VSCode xml all
duti -s com.microsoft.VSCode opml all
duti -s com.microsoft.VSCode js all
duti -s com.microsoft.VSCode json all
duti -s com.microsoft.VSCode css all
duti -s com.microsoft.VSCode md all

# PDF 文件使用 Safari
duti -s com.apple.Safari pdf all

echo "默认应用程序设置已完成。"

# 根据需要添加更多的文件类型和应用程序
