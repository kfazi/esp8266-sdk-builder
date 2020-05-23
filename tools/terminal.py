import argparse
import queue
import socket
import sys
import threading

import serial
from serial.tools.list_ports import main as list_ports_main
from serial.tools.miniterm import Miniterm


class Terminal:
    def __init__(self, args):
        self.args = args
        self.messages = queue.Queue()

        self.finished = False

    def client_entry(self, serv_sock):
        serv_sock.settimeout(0.2)
        while not self.finished:
            try:
                sock, address = serv_sock.accept()
                with sock:
                    self.messages.put(sock.recv(1024))
            except socket.timeout:
                pass

    def run(self):
        serial_instance = serial.serial_for_url(
            self.args.port, self.args.baud, parity='N', rtscts=False, xonxoff=False, do_not_open=True)

        serial_instance.open()

        miniterm = Miniterm(serial_instance, echo=False, eol='crlf', filters=['default'])
        miniterm.exit_character = chr(3)
        miniterm.menu_character = chr(20)
        miniterm.raw = False
        miniterm.set_rx_encoding('UTF-8')
        miniterm.set_tx_encoding('UTF-8')

        print('Serial port connected')

        miniterm.start()

        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            sock.bind(('localhost', 5555))
            sock.listen(1)

            client_thread = threading.Thread(target=self.client_entry, args=(sock, ))
            client_thread.start()

            stopped = False
            try:
                while stopped or miniterm.alive:
                    try:
                        message = self.messages.get(timeout=0.2)

                        if not stopped and message == b'stop':
                            stopped = True
                            miniterm.stop()
                            miniterm.console.cancel()
                            miniterm.join()
                            serial_instance.close()
                            print('Serial port disconnected')

                        if stopped and message == b'start':
                            serial_instance.open()
                            miniterm.start()
                            stopped = False
                            print('Serial port connected')
                    except queue.Empty:
                        pass
            finally:
                self.finished = True
                client_thread.join()
                if miniterm.alive:
                    miniterm.stop()
                    miniterm.join()
                    miniterm.close()
                    serial_instance.close()


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('-l', '--list', action='store_true', help='list serial ports')

    parser.add_argument('-b', '--baud', type=int, default=115200, help='baud rate')
    parser.add_argument('port', metavar='PORT', help='serial port name')

    args = parser.parse_args()

    if args.list:
        sys.argv = ['list_ports']
        list_ports_main()
        return

    terminal = Terminal(args)
    try:
        terminal.run()
    except KeyboardInterrupt:
        pass


main()
