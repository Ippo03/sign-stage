import json

from flask import Flask, jsonify, request

app = Flask(__name__)

def generate_response(message):
    # AI logic goes here
    # sleep for 3 seconds to simulate AI processing
    import time
    time.sleep(3)
    
    response = message + " ANSWERED BY AI"
    return response

@app.route('/send_message', methods=['POST'])
def send_message():
    data = request.get_json()
    message = data.get('message', '')
    
    if message:
        response_message = generate_response(message)
        return jsonify({'response': response_message})
    else:
        return jsonify({'error': 'No message provided'}), 400

if __name__ == '__main__':
    app.run(host='192.168.244.61', port=5000, debug=True)
