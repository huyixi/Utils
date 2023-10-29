import os
import frontmatter
import re

# 定义遍历的目录
dir_path = './'  # 当前目录

for dirpath, dirnames, filenames in os.walk(dir_path):
    for filename in filenames:
        if filename.endswith('.md'):
            filepath = os.path.join(dirpath, filename)
            with open(filepath, 'r', encoding='utf-8') as file:
                content = file.read()
                # 通过正则表达式检查是否存在 date 字段但缺少 lastmod 字段
                date_match = re.search(r'date: (.+)', content)
                lastmod_match = re.search(r'lastmod: (.+)', content)
                
                if date_match and not lastmod_match:
                    date_value = date_match.group(1)
                    # 在 date 字段后插入 lastmod 字段
                    content = content.replace(f"date: {date_value}", f"date: {date_value}\nlastmod: {date_value}")
                    
                    # 将更新的内容写回文件
                    with open(filepath, 'w', encoding='utf-8') as file:
                        file.write(content)

print("Script completed!")
