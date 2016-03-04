package com.rest.test;

import java.net.URI;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import org.glassfish.jersey.client.ClientConfig;

import com.rest.test.Student;

public class XMLClient {

    public static void main(String[] args) {

        // GET 
        Client client = ClientBuilder.newClient();
        WebTarget target = client.target(getBaseURI()).path("student").path("James"); 
        Invocation.Builder invocation =  target.request(MediaType.APPLICATION_XML);
        Response response = invocation.get();    

        if (response.getStatus() != 200) {
           throw new RuntimeException("Failed : HTTP error code : "
            + response.getStatus());
        } 

        Student output = new Student();
        output = response.readEntity(Student.class);//Get the object from the response     
        System.out.println("Output xml client .... \n");
        System.out.println(output);      

        // If the XML response is needed instead of the actual object 
        //System.out.println(response.readEntity(String.class));
    
    } 

    private static URI getBaseURI() {
        return UriBuilder.fromUri("http://node-0:8080/rest/xmlServices").build();
    } 
}
