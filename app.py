from flask import Flask
import logging
import sys

app = Flask(__name__)

@app.route('/')
def hello_world():
    app.logger.info('Hello, World! endpoint was reached')
    return 'Hello, World!'

if __name__ == '__main__':
    # Set up logging to output to stdout
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)

    # Add a log handler to ensure logs go to stdout
    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(logging.INFO)
    app.logger.addHandler(handler)

    app.run(host='0.0.0.0', port=5000)
