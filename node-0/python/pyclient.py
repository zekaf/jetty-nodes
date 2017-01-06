#!/usr/bin/python

import websocket

websocket.enableTrace(True)
ws = websocket.create_connection("ws://localhost:8081/ws/wsexample")
print "Sending message"
ws.send("Hello server")
result = ws.recv()
print "Received '%s'" % result 
