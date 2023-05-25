# 提示输入文件名
echo "请输入 DOM 元素所在的文件名(放置在同一目录下)： "
read FILE_NAME

# 读取文件中的内容
DOM=$(cat "$FILE_NAME")

# 提取 href 属性
hrefs=$(echo $DOM | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//')

# 输出第一个获取到的 href
first_href=$(echo "$hrefs" | head -n 1)
echo "第一个获取到的 href 是：$first_href"

# 提示是否添加前缀
echo "是否要添加前缀？ (输入 Y 或 N) "
read PREFIX_CHOICE

# 根据用户的选择，可能会添加前缀
if [[ "$PREFIX_CHOICE" == "Y" || "$PREFIX_CHOICE" == "y" ]]
then
    echo "请输入前缀: "
    read PREFIX
    hrefs=$(echo "$hrefs" | sed "s@^@${PREFIX}@")
fi

# 输出结果
echo "$hrefs"
