import socket
import sys
import time

import esptool


def send(message: str, wait: bool) -> None:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        try:
            sock.settimeout(0.1)
            sock.connect(('localhost', 5555))
            sock.send(message)
            time.sleep(0.25)
        except socket.timeout as w:
            pass


print('Stopping terminal...')
send(b'stop', True)

esptool.main()

print('Restarting terminal...')
send(b'start', False)
