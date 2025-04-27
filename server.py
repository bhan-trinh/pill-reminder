import flask
import re
from flask_restful import Resource, Api
from google import genai
import os
from dotenv import load_dotenv
# import threading

# import time
# import datetime
# from backend.hardware.python import serialcontrol
# import serial
# from serial.tools import list_ports
# import checkport

load_dotenv()

api_key = os.getenv('API_KEY')
client = genai.Client(api_key=api_key)

app = flask.Flask(__name__)
api = Api(app)

def ocr(filename):
    
    file = client.files.upload(file=filename)
    response = client.models.generate_content(
        model="gemini-2.0-flash-001", 
        contents=["Output the contents of this label into a python dictionary listing the medication name, dosage, instructions, and times. Only output the dictionary, nothing else. Don't include backslash in the keys.",file])

    medication_name = re.search("\"medication_name\": \"(.*)\"", str(response.text)).group(1)
    dosage = re.search("\"dosage\": \"(.*)\"", str(response.text)).group(1)
    instructions = re.search("\"instructions\": \"(.*)\"", str(response.text)).group(1)
    times = re.search("\"times\": (.*)", str(response.text)).group(1)

    return {"medication_name":medication_name, "dosage":dosage, "instructions":instructions, "times":times}



class Label(Resource):
    def post(self):
        file = flask.request.files['file']
        temp_path = f"/tmp/{file.filename}"  # save inside /tmp, safe on Render
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
    return {"message": "Server is running!"},200


if __name__ == "__main__":
    # threading.Thread(target=checkport.runSerial).start()
    app.run(debug=True, host="0.0.0.0", port=10000)