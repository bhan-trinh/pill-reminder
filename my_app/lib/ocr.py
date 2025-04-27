import flask
import re
from flask_restful import Resource, Api
from google import genai
client = genai.Client(api_key="AIzaSyA2EKW02XxzXGUX3xCw_h2mWoES8Aq0yK0")

app = flask.Flask(__name__)
api = Api(app)

file = client.files.upload(file="label.png")
response = client.models.generate_content(
    model="gemini-2.0-flash-001", 
    contents=["Output the contents of this label into a python dictionary listing the medication name, dosage, instructions, and times. Only output the dictionary, nothing else",file])

medication_name = re.search("\"medication_name\": \"(.*)\"", str(response.text)).group(1)
dosage = re.search("\"dosage\": \"(.*)\"", str(response.text)).group(1)
instructions = re.search("\"instructions\": \"(.*)\"", str(response.text)).group(1)
times = eval(re.search("\"times\": (.*)", str(response.text)).group(1))



class Label(Resource):
    def get(self):
        return {
            "Medication" : medication_name,
            "Dosage" : dosage,
            "Instructions" : instructions,
            "Times" : times,
        }

api.add_resource(Label, "/")
if __name__ == "__main__":
    print(response.text)
    app.run(debug=True, host="0.0.0.0", port=8080)