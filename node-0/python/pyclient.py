#!/usr/bin/python

import websocket

websocket.enableTrace(True)
ws = websocket.create_connection("ws://node-0:8080/ws/wsexample")
msg = "Hello Server"
print "SENT: %s" %msg
ws.send(msg)
result = ws.recv()
print "RESPONSE: %s" % result
