from flask import Flask, jsonify
import os

app = Flask(__name__)

# Example route
@app.route('/api/hello', methods=['GET'])
def hello():
    return jsonify({"message": "Hello from the backend!"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

