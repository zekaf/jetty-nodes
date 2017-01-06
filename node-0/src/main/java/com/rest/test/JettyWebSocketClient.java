package com.rest.test;

import org.eclipse.jetty.websocket.api.Session;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketClose;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketConnect;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketMessage;
import org.eclipse.jetty.websocket.api.annotations.WebSocket;
import org.eclipse.jetty.websocket.client.ClientUpgradeRequest;
import org.eclipse.jetty.websocket.client.WebSocketClient;
import java.io.IOException;
import java.net.URI;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

public class JettyWebSocketClient {

    public static void main(String[] args) throws Exception {
        
        JettyWebSocketClient app = new JettyWebSocketClient();
        app.start();
    }
    
    public void start() throws Exception {

        WebSocketClient client = new WebSocketClient();
        MyWebSocket socket = new MyWebSocket();
        
        client.start();
        
        URI destUri = new URI("ws://node-0:8080/ws/wsexample");
        
        ClientUpgradeRequest request = new ClientUpgradeRequest();
        System.out.println("Connecting to: " + destUri);
        client.connect(socket, destUri, request);
        socket.awaitClose(5, TimeUnit.SECONDS);

        client.stop();
    }

    @WebSocket
    public class MyWebSocket {
    
        private final CountDownLatch closeLatch = new CountDownLatch(1);

        @OnWebSocketConnect
        public void onConnect(Session session) throws IOException {
        
            System.out.println("Sending message: Hello server");
            session.getRemote().sendString("Hello server");
        }

        @OnWebSocketMessage
        public void onMessage(String message) {
            System.out.println("Message from Server: " + message);
        }

        @OnWebSocketClose
        public void onClose(int statusCode, String reason) {
            System.out.println("WebSocket Closed. Code:" + statusCode);
        }

        public boolean awaitClose(int duration, TimeUnit unit) 
                throws InterruptedException {
            return this.closeLatch.await(duration, unit);
        }
    }
}
