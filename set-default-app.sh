#!/bin/bash

# How to find App Bundle Identifiers(Bundle ID) of software?
# For example:
# mdls -name kMDItemCFBundleIdentifier /System/Applications/Books.app
# Get all bundle identifiers in /Applications
# lsappinfo list | rg --multiline '("[^"]*?") ASN:.*\n.*bundleID=("[^"]*?")' --replace '$1 $2' --only-matching

# System-Declared Uniform Type Identifiers
# https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html#//apple_ref/doc/uid/TP40009259

# 检查 duti 是否安装
if ! command -v duti &> /dev/null; then
    echo "duti 未安装。请先安装 duti。"
    exit 1
fi

# 设置文件类型与应用程序的关联
fileAssociations=(
    # 图片文件
    "com.interversehq.qView jpg"
    "com.interversehq.qView jpeg"
    "com.interversehq.qView png"
    "com.interversehq.qView gif"
    "com.interversehq.qView tiff"
    "com.interversehq.qView bmp"
    "com.interversehq.qView heic"
    # 视频文件
    "com.colliderli.iina mov"
    "com.colliderli.iina mp4"
    "com.colliderli.iina avi"
    "com.colliderli.iina mkv"
    "com.colliderli.iina m4v"
    # 文本文件
    "dev.zed.Zed txt"
    "dev.zed.Zed xml"
    "dev.zed.Zed opml"
    "dev.zed.Zed json"
    "dev.zed.Zed css"
    "dev.zed.Zed js"
    "dev.zed.Zed ts"
    "dev.zed.Zed tsx"
    "dev.zed.Zed pub"
    "dev.zed.Zed yaml"
    "dev.zed.Zed csv"
    "abnerworks.Typora md"
    "com.microsoft.Excel xls"
    "com.microsoft.Excel xlsx"
    # PDF 文件
    "com.google.Chrome pdf"
)

# 错误日志
errors=()

# 应用设置
for association in "${fileAssociations[@]}"; do
    app=$(echo "$association" | awk '{print $1}')
    ext=$(echo "$association" | awk '{print $2}')
    if ! duti -s "$app" "$ext" all; then
        errors+=("设置 $ext 类型的默认应用程序为 $app 失败。")
    fi
done

# 输出错误日志
if [ ${#errors[@]} -ne 0 ]; then
    echo "以下文件类型的默认应用程序设置失败："
    for error in "${errors[@]}"; do
        echo "$error"
    done
    exit 1
else
    echo "默认应用程序全部设置成功。"
fi
