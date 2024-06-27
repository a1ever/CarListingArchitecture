import os
import re
import subprocess
import time
from datetime import datetime

def backup():
    filepath = f"/src/BACKUPER_{datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.sql"
    print(filepath,os.getenv("DB_HOST"),
       os.getenv("DB_PORT"),
         os.getenv("DB_USERNAME"),
         os.getenv("DB_NAME"), os.getenv("DB_PASSWORD"))
    print("ok")
    try:
        subprocess.call(
        ["pg_dump",
         "-h", os.getenv("DB_HOST"),
         "-p", os.getenv("DB_PORT"),
         "-U", os.getenv("DB_USERNAME"),
         "-d", os.getenv("DB_NAME"),
         "-f", filepath],
            env={"PGPASSWORD": os.getenv("DB_PASSWORD")},)
    except Exception as e:
        print(e)
    print("ok2")

def backup_cleanup(n):
    print("here")
    pattern = re.compile(r"BACKUPER_([0-9-_]*)\.sql")

    backups = []

    for filename in os.listdir("/src"):
        print(filename)
        match = pattern.match(filename)
        print(match)
        if match:
            datetime_str = match.group(1)
            datetime_obj = datetime.strptime(datetime_str, "%Y-%m-%d_%H-%M-%S")
            backups.append((filename, datetime_obj))

    backups.sort(key=lambda x: x[1], reverse=True)

    print("backups", backups)

    to_keep = backups[:n-1]
    to_delete = backups[n:]

    print("to_keep", to_keep)
    print("to_delete", to_delete)

    for filename, _ in to_delete:
        os.remove(os.path.join("/src", filename))
        print("delete", filename)

interval = int(os.getenv("BACKUP_INTERVAL_HRS"))
limit = int(os.getenv("BACKUP_LIMIT"))

while True:
    backup()
    print("Backup Complete")
    backup_cleanup(limit)
    print("Backup Cleared")
    time.sleep(interval*3600)