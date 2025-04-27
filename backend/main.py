import time
import datetime
from backend.hardware.python import serialcontrol

def runSerial():
    last_drop_date = None
    scheduled_hour = 7 
    while True:
        now = datetime.datetime.now()
        current_date = now.date()
        current_hour = now.hour

        if current_hour == scheduled_hour and current_date != last_drop_date:
            try:
                serialcontrol.dropPills(
                    dose=2,
                    time_to_drop=scheduled_hour,
                    serial_port=1201
                )
                last_drop_date = current_date 
                print(f"[{now}] Pills dropped successfully.")
            except Exception as e:
                print(f"Error dropping pills: {e}")
        time.sleep(30)
