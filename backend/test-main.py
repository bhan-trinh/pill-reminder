from flask import Flask, jsonify, request
from pymongo import MongoClient
import os

app = Flask(__name__)

# MongoDB connection string from Heroku environment variables
mongo_uri = os.getenv("MONGO_URI")  # MONGO_URI set in Heroku config vars
client = MongoClient(mongo_uri)

# Access the database
db = client.get_database('your_database_name')  # Replace with your DB name
collection = db.get_collection('your_collection_name')  # Replace with your collection name

@app.route('/add', methods=['POST'])
def add_document():
    data = request.json  # Get data from the incoming POST request
    result = collection.insert_one(data)  # Insert into MongoDB
    return jsonify({"message": "Document added", "id": str(result.inserted_id)})

@app.route('/get', methods=['GET'])
def get_documents():
    documents = collection.find()  # Retrieve all documents
    result = []
    for doc in documents:
        doc['_id'] = str(doc['_id'])  # Convert ObjectId to string for JSON serialization
        result.append(doc)
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
