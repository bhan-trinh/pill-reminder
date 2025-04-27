import serial
import time
import datetime

def dropPills(dose, time_to_drop, serial_port):
    print('Start drop pill func')
    if dose not in [1, 2, 3]:
        raise ValueError("Dose must be 1, 2, or 3.")
    if not (0 <= time_to_drop <= 23):
        raise ValueError("Time must be between 0 and 23.")
    now = datetime.datetime.now()
    if now.hour == time_to_drop:
        try:
            print(f"Trying to open serial port: {serial_port}")
            ser = serial.Serial(serial_port, 9600, timeout=1)
            time.sleep(2)
            ser.write(str(dose).encode())
            ser.flush()
            time.sleep(1)
            print(f"Sent dose {dose} to serial port {serial_port}")
        except serial.SerialException as e:
            print(f"Error with the serial connection: {e}")


