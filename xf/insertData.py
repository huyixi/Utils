import datetime
import json
import sqlite3

def insert_data_to_db(filename='input.json'):
    conn = sqlite3.connect('data.db')
    cursor = conn.cursor()

    cursor.execute('''
    CREATE TABLE IF NOT EXISTS records (
        id TEXT PRIMARY KEY,
        fileName TEXT,
        createTime TEXT,
        summary TEXT
    )
    ''')

    with open(filename, 'r', encoding='utf-8') as file:
        data = json.load(file)

    for record in data["data"]["records"]:
        if record["summary"]:  # Only insert if summary is not empty
            cursor.execute('''
            INSERT OR IGNORE INTO records (id, fileName, createTime, summary)
            VALUES (?, ?, ?, ?)
            ''', (record["id"], record["fileName"], datetime.datetime.fromtimestamp(record["createTime"] / 1000).strftime('%Y-%m-%d %H:%M:%S'), record["summary"]))

    conn.commit()
    conn.close()

    return "Data inserted/updated in SQLite database 'data.db'."