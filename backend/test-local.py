import requests
import json

url = "https://pills-dispenser-7f1389ec1c6b.herokuapp.com/add"  # Replace with your actual Heroku URL

data = {
    "name": "Bob",
    "age": 30,
    "city": "Los Angeles"
}

# Send a POST request to the Flask app on Heroku
response = requests.post(url, json=data)

# Print the response from the Flask app
print(response.json())
