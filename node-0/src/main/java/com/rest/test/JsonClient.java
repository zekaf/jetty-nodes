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

import com.rest.test.Employee;

public class JsonClient {

    public static void main(String[] args) {

        /*
        String responseEntity = ClientBuilder.newClient()
            .target(getBaseURI()).path("getEmployee")
                        .request().get(String.class);

        System.out.println(responseEntity);
        */

        // GET
        Client client = ClientBuilder.newClient();
        WebTarget target = client.target(getBaseURI()).path("getEmployee"); 
        Invocation.Builder invocation =  target.request(MediaType.APPLICATION_JSON);
        Response response = invocation.get();    

        if (response.getStatus() != 200) {
           throw new RuntimeException("Failed : HTTP error code : "
            + response.getStatus());
        }       

        Employee output = new Employee();
        output = response.readEntity(Employee.class);//Get the object from the response     
        System.out.println("Output json client .... \n");
        System.out.println(output);

        // If the JSON response is needed instead of the actual object 
        //System.out.println(response.readEntity(String.class));
        
    }

    private static URI getBaseURI() {
        return UriBuilder.fromUri("http://node-0:8080/rest/employee").build();
    } 
}
