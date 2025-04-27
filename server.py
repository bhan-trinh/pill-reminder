import flask
import re
from flask_restful import Resource, Api
from google import genai
import os
import time
import datetime
import threading
from backend.hardware.python import serialcontrol
from dotenv import load_dotenv
import serial

load_dotenv()

api_key = os.getenv('API_KEY')
client = genai.Client(api_key=api_key)

app = flask.Flask(__name__)
api = Api(app)

pill_drop_status = None

def check_serial_connection(port):
    port = f'/dev/tty.usbmodem{port}'
    try:
        ser = serial.Serial(port)
        if ser.is_open:
            return True
        else:
            return False
    except serial.SerialException:
        return False

def ocr(filename):
    file = client.files.upload(file=filename)
    response = client.models.generate_content(
        model="gemini-2.0-flash-001", 
        contents=["Output the contents of this label into a python dictionary listing the medication name, dosage, instructions, and times. Only output the dictionary, nothing else",file])

    medication_name = re.search("\"medication_name\": \"(.*)\"", str(response.text)).group(1)
    dosage = re.search("\"dosage\": \"(.*)\"", str(response.text)).group(1)
    instructions = re.search("\"instructions\": \"(.*)\"", str(response.text)).group(1)
    times = re.search("\"times\": (.*)", str(response.text)).group(1)

    return {"medication_name":medication_name, "dosage":dosage, "instructions":instructions, "times":times}

def runSerial():
    global pill_drop_status
    scheduled_hour = 7 
    last_drop_date = None
    while True:
        current_date = datetime.datetime.now().date
        serial_status = "connected" if check_serial_connection(1101) else "thread running, not connected"
        print(f"Serial Status: {serial_status}")
        if serial_status == "connected" and last_drop_date != current_date:
            print(f"Serial port connected, attempting to drop pills...")
            serialcontrol.dropPills(
                dose=2,
                time_to_drop=scheduled_hour,
                serial_port=1101
            )
            print("Pills dropped successfully.")
            pill_drop_status = "Pills dropped successfully."
            last_drop_date == current_date
        time.sleep(30)

class Label(Resource):
    def post(self):
        file = flask.request.files['file']
        temp_path = f"/tmp/{file.filename}"
        file.save(temp_path)

        output = ocr(temp_path)

        os.remove(temp_path)

        return {
            "Medication" : output["medication_name"],
            "Dosage" : output["dosage"],
            "Instructions" : output["instructions"],
            "Times" : output["times"],
        }

api.add_resource(Label, "/")

@app.route("/", methods=["GET"])
def home():
    serial_status = "connected" if check_serial_connection(1101) else "thread running, not connected"
    return {
        "message": "Server is running!",
        "serial_status": serial_status,
        "pill_drop_status": pill_drop_status 
    }, 200

if __name__ == "__main__":
    threading.Thread(target=runSerial).start()
    app.run(debug=True, host="0.0.0.0", port=10000)
