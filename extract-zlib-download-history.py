import csv
from datetime import datetime
import os
import fnmatch


def process_data(reader, time_col, book_col):
    processed_data = []
    next(reader)  # 跳过表头

    for row in reader:
        # 确保行数据完整
        if len(row) <= max(time_col, book_col):
            print(f"Skipping row (invalid format): {row}")
            continue

        # 解析时间和书名
        time_lines = row[time_col].strip().split('\n')
        book_name = row[book_col].strip()

        try:
            date_str = time_lines[0].strip()  # 日期部分
            time_str = time_lines[2].strip()  # 时间部分

            datetime_str = f"{date_str} {time_str}"
            date_obj = datetime.strptime(datetime_str, '%d.%m.%Y %H:%M')
            iso_time = date_obj.isoformat()

        except (IndexError, ValueError) as e:
            print(f"Skipping row (parse error): {row}, Error: {e}")
            continue

        processed_data.append([iso_time, book_name])

    return processed_data


def process_file(file_path, output_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)

        # 确认表头包含 'time' 和 'book-name'
        try:
            time_col = header.index('time')
            book_col = header.index('book-name')
        except ValueError:
            print(f"Skipping file (missing required columns): {file_path}")
            return

        print(f"Processing file: {file_path} (time_col={time_col}, book_col={book_col})")
        f.seek(0)
        reader = csv.reader(f)
        processed_data = process_data(reader, time_col, book_col)

    # 写入输出文件
    with open(output_path, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['iso_time', 'book_name'])
        writer.writerows(processed_data)

    print(f"Processed data written to {output_path}")


def process_all_files(directory):
    # 遍历目录，查找以 zlib 开头的 csv 文件
    for file_name in os.listdir(directory):
        if fnmatch.fnmatch(file_name, 'zlib*.csv'):
            input_path = os.path.join(directory, file_name)
            output_path = os.path.join(directory, file_name)

            process_file(input_path, output_path)


# 示例：指定目录
input_directory = './'  # 当前目录
process_all_files(input_directory)
