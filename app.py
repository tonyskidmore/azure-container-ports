"""multi-port testing"""

import socket
import threading
from flask import Flask

app = Flask(__name__)


@app.route('/')
def http_endpoint():
    """HTTP endpoint"""
    return 'Hello from HTTP!'


def tcp_server():
    """TCP server"""
    host = '0.0.0.0'  # Listen on all interfaces
    port = 5001       # Non-HTTP port

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((host, port))
        s.listen()

        while True:
            conn, addr = s.accept()
            with conn:
                print(f'Connected by {addr}')
                conn.sendall(b'Hello from TCP!')


if __name__ == '__main__':
    threading.Thread(target=tcp_server, daemon=True).start()
    app.run(host='0.0.0.0', port=5000)
