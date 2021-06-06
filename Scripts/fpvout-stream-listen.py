#!/usr/bin/python3
# 
# A server that waits for connections and pipes the output of fpv-c to the 
# remote client. The client will be an h264 stream (without an MP4 wrapper)
# so clients will need to act accordingly. To view the stream in VLC open
# a url: tcp/h264://fpvout.local:8081
# 
# This service can be used to create a simple device that will clients such
# as iOS to connect to DJI FPV goggles. I haven't tested yet, but I suspect
# even a Pi Zero could handle it since it's just redirecting USB to Wifi and
# not even decoding the video. That said my Pi 4 has horrible latency, so this
# may not work.

import socket
import subprocess
import sys

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = ('', 8081)
print('starting up on %s port %s' % server_address, file=sys.stderr)
sock.bind(server_address)

# Listen for incoming connections
sock.listen(1)

while True:
    # Wait for a connection
    print('waiting for a connection', file=sys.stderr)
    connection, client_address = sock.accept()

    try:
        print('connection from %s port %s' % client_address, file=sys.stderr)
        
        socket_input = connection.makefile('wb',0)
        proc = subprocess.run(['/home/fpvout/Scripts/fpv-c/fpv-video-out'], stdout=socket_input)
    finally:
        # Clean up the connection
        print('closed connection from %s port %s' % client_address, file=sys.stderr)
        connection.close()

