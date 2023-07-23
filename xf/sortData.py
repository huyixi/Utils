import sqlite3
import datetime
import os

def export_records(duration="3"):
    # Connect to the SQLite database
    conn = sqlite3.connect('data.db')
    cursor = conn.cursor()

    # Calculate the starting date based on the given duration
    today = datetime.datetime.now()
    
    if isinstance(duration, (int, str)) and duration.isdigit():
        start_date = (today - datetime.timedelta(days=int(duration))).strftime('%Y-%m-%d %H:%M:%S')
    elif duration == "周":
        start_date = (today - datetime.timedelta(days=7)).strftime('%Y-%m-%d %H:%M:%S')
    elif duration == "月":
        # Calculate start date as the same day of the previous month
        if today.month == 1:
            start_date = today.replace(year=today.year-1, month=12).strftime('%Y-%m-%d %H:%M:%S')
        else:
            start_date = today.replace(month=today.month-1).strftime('%Y-%m-%d %H:%M:%S')
    elif duration == "年":
        start_date = today.replace(year=today.year-1).strftime('%Y-%m-%d %H:%M:%S')
    else:
        raise ValueError("Invalid duration provided.")
    
    cursor.execute('''
    SELECT fileName, createTime, summary FROM records WHERE createTime >= ? ORDER BY createTime
    ''', (start_date,))
    records = cursor.fetchall()

    # Generate the total summary from all summaries
    total_summary = "\n".join([record[2] for record in records if record[2]])

    # Generate the text to save
    text_to_save = f"Total Summary:\n{total_summary}\n\n"
    for record in records:
        text_to_save += f"File Name: {record[0]}\nCreation Time: {record[1]}\nSummary:\n{record[2]}\n\n"

    # Generate the file name based on the start and end dates
    end_date = today.strftime('%Y%m%d')
    start_date_str = datetime.datetime.strptime(start_date, '%Y-%m-%d %H:%M:%S').strftime('%Y%m%d')
    sorted_file_name = f"讯飞录音笔_{start_date_str}_{end_date}.txt"
    sorted_file_path = os.path.join(os.getcwd(), sorted_file_name)
    
    with open(sorted_file_path, 'w', encoding='utf-8') as file:
        file.write(text_to_save)

    conn.close()

    return sorted_file_name

if __name__ == "__main__":
    file_name = export_records()
    print(f"Data exported to '{file_name}'.")