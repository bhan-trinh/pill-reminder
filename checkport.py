
import time
import datetime

from backend.hardware.python import serialcontrol
from dotenv import load_dotenv
import serial
from serial.tools import list_ports

load_dotenv()


pill_drop_status = None
connected_port = None

def find_connected_port():
    global connected_port
    ports = list_ports.comports()
    # print("Available ports:", ports)
    for port in ports:
        if 'usbmodem' in port.device:
            connected_port = port.device
            print(f"Found connected port: {connected_port}")
            return connected_port
    return None


def check_serial_connection():
    if connected_port:
        try:
            ser = serial.Serial(connected_port)
            if ser.is_open:
                return True
        except serial.SerialException:
            return False
    return False


def runSerial():
    global pill_drop_status
    scheduled_hour = 8
    last_drop_date = None
    
    while not connected_port:
        print("Waiting for serial port to connect...")
        find_connected_port()
        time.sleep(5)

    while True:
        current_date = datetime.datetime.now().date
        serial_status = "connected" if check_serial_connection() else "thread running, not connected"
        print(f"Serial Status: {serial_status}")
        
        if serial_status == "connected" and last_drop_date != current_date:
            print(f"Serial port connected ({connected_port}), attempting to drop pills...")
            serialcontrol.dropPills(
                dose=2,
                time_to_drop=scheduled_hour,
                serial_port=connected_port
            )
            print("Pills dropped successfully.")
            pill_drop_status = "Pills dropped successfully."
            last_drop_date = current_date
        time.sleep(5)
runSerial()