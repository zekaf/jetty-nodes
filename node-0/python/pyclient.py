#!/usr/bin/python

import websocket

websocket.enableTrace(True)
ws = websocket.create_connection("ws://node-0:8080/ws/wsexample")
print "Sending message"
ws.send("Hello server")
result = ws.recv()
print "Received '%s'" % result 
