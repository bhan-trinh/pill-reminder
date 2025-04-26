import flask
from flask_restful import Resource, Api
import matplotlib as plt
import keras_ocr

pipeline = keras_ocr.pipeline.Pipeline()

read_image = keras_ocr.tools.read("label.png")
read_text = pipeline.recognize(read_image)

fig, axs = plt.subplots(nrows=len(read_image), figsize=(20, 20))
for ax, image, predictions in zip(axs, read_image, read_text):
    keras_ocr.tools.drawAnnotations(image=image, predictions=predictions, ax=ax)

app = flask.Flask(__name__)
api = Api(app)

class LabelText(Resource):
    def get(self):
        return {
            "hello": "world",
        }
api.add_resource(LabelText,"/")

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)