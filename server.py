import flask
import re
from flask_restful import Resource, Api
from google import genai
import os

api_key = os.getenv('API_KEY')
client = genai.Client(api_key=api_key)

app = flask.Flask(__name__)
api = Api(app)

def ocr(file_bytes):
    file = client.files.upload_bytes(file_bytes, mime_type='image/jpg')
    response = client.models.generate_content(
        model="gemini-2.0-flash-001", 
        contents=["Output the contents of this label into a python dictionary listing the medication name, dosage, instructions, and times. Only output the dictionary, nothing else",file])

    medication_name = re.search("\"medication_name\": \"(.*)\"", str(response.text)).group(1)
    dosage = re.search("\"dosage\": \"(.*)\"", str(response.text)).group(1)
    instructions = re.search("\"instructions\": \"(.*)\"", str(response.text)).group(1)
    times = eval(re.search("\"times\": (.*)", str(response.text)).group(1))

    return {"medication_name":medication_name, "dosage":dosage, "instructions":instructions, "times":times}



class Label(Resource):
    def post(self):

        file = flask.request.files['file']
        file_bytes = file.read()

        output = ocr(file_bytes)

        return {
            "Medication" : output["medication_name"],
            "Dosage" : output["dosage"],
            "Instructions" : output["instructions"],
            "Times" : output["times"],
        }

api.add_resource(Label, "/")

@app.route("/", methods=["GET"])
def home():
    return {"message": "Server is running!"}, 200

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=10000)