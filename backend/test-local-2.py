import requests

url = "https://pills-dispenser-7f1389ec1c6b.herokuapp.com/"  # Replace with your actual Heroku URL

# Send a GET request to the Flask app on Heroku
response = requests.get(url)

# Print the response from the Flask app (list of documents)
print(response.json())
