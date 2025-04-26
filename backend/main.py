# from hardware.python import serialcontrol
# def main(): 
#     serialcontrol.dropPills(dose=2, time_to_drop=19, serial_port=1201)

from flask import Flask, jsonify, request
from pymongo import MongoClient
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

mongo_uri = os.getenv("MONGO_URI")
client = MongoClient(mongo_uri)

db = client.get_database('sample_mflix')
collection = db.get_collection('movies')

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/add', methods=['POST'])
def add_item():
    item = request.json
    collection.insert_one(item)
    return jsonify({"message": "Item added!"}), 201

@app.route('/items', methods=['GET'])
def get_items():
    items = list(collection.find())
    for item in items:
        item["_id"] = str(item["_id"])
    return jsonify(items)

if __name__ == '__main__':
    app.run(debug=True)
