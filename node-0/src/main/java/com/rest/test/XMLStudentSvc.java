package com.rest.test;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.rest.test.Student;

@Path("/xmlServices")
public class XMLStudentSvc {
     @GET
     @Path("/student/{name}")
     @Produces(MediaType.APPLICATION_XML)
     public Student getStudent( @PathParam("name") String name ) {
         Student st = new Student(name, "Smith", 22, 1);
         return st;
     }
}
