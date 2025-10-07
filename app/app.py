# app/app.py
from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return jsonify({
        "message": "Hello, World from Kubernetes!",
        "host": socket.gethostname(),
        "environment": os.getenv("ENV", "development")
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)