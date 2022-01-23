import socket
import os
import subprocess

HOST = ''
PORT = 65432
PATH = os.path.dirname(__file__)


class Command(object):
    def __init__(self, id, conn, addr):
        self.id = id
        self.conn = conn
        print(f'[{id}] {addr[0]}:{addr[1]}')

    def execute(self, data):
        command, send = data[0:2], ''
        data = data[3:]
        loc = os.path.join(PATH, f'reactor/{data}')
        if command == 'cd':
            resp = PATH
        elif command == 'cf':
            try:
                fp = open(loc, 'x')
                fp.close()
                resp = '1'
            except:
                resp = '0'
        elif command == 'df':
            if os.path.exists(loc):
                os.remove(loc)
                resp = '1'
            else:
                resp = '0'
        elif command == 'vf':
            try:
                fp = open(loc, 'r')
                send = '>>' + fp.read() + '<<\n'
                resp = str(os.path.getsize(loc))
                fp.close()
            except:
                resp = '0'
        elif command == 'ef':
            index = data.find(' ')
            file = data[:index]
            data = data[index + 1:]
            loc = os.path.join(PATH, f'reactor/{file}')
            loc = os.path.join(PATH, f'reactor/{file}')
            try:
                fp = open(loc, 'w')
                fp.write(data)
                fp.close()
                resp = '1'
            except:
                resp = '0'
        elif command == 'rc':
            try:
                lt = data.split(' ')
                subprocess.Popen(lt)
                resp = '1'
            except:
                resp = '0'
        else:
            resp = 'UNDEFINED'

        if send == '':
            conn.sendall(resp.encode('utf-8'))
            print(f'  [SEND] {resp}')
        else:
            conn.sendall((send + resp).encode('utf-8'))
            print(f'  [SEND] ...')
            print(f'  [SEND] {resp}')


obj = None
serverStatus = True
flag = True


while(serverStatus):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()
        if flag:
            reactor = os.path.join(PATH, 'reactor')
            if(not os.path.exists(reactor)):
                os.mkdir(reactor)
            print(f'\n=== SERVER LIVE ===\n')
            flag = False
        conn, addr = s.accept()
        with conn:
            id = conn.recv(1024).decode('utf-8')
            obj = Command(id, conn, addr)
            while True:
                # Continuous Recieve Only Logic
                raw = conn.recv(1024)

                data = raw.decode('utf-8')
                if(data[:2] == 'ef'):

                    print(f'  [RECV] {data[:data[3:].find(" ") + 3]} ...')
                else:
                    print(f'  [RECV] {data}')

                if data == 'end':
                    print(f'[{id}] Logout')
                    break
                elif data == 'shutdown':
                    print(f'\n=== SERVER DOWN ===')
                    serverStatus = False
                    break
                obj.execute(data)
