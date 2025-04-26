import serial
import time

arduino_port = "COM3"  # Replace with your Arduino port
baud_rate = 9600
ser = serial.Serial(arduino_port, baud_rate, timeout=1)

time.sleep(2) # wait for the serial connection to initialize


def send_data():
    data_to_send = "Hello from Python!"
    ser.write(data_to_send.encode())
    print(f"Sent to Arduino: {data_to_send}")


def receive_data():
    ser.write("Request data".encode())
    received_data = ser.readline().decode().strip()
    print(f"Received from Arduino: {received_data}")

ser.close()
