package com.rest.crud;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import javax.xml.bind.JAXBElement;

public class CasResource {

	@Context
	UriInfo uriInfo;
	@Context
	Request request;
	String id;

	CasService casService;

	public CasResource(UriInfo uriInfo, Request request, String id) {
		this.uriInfo = uriInfo;
		this.request = request;
		this.id = id;
		casService = new CasService();
	}

	@GET
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public Cas getCas() {
		Cas cas = casService.getCas(id);
		return cas;
	}

	@GET
	@Produces(MediaType.TEXT_XML)
	public Cas getCasAsHtml() {
		Cas cas = casService.getCas(id);
		return cas;
	}

	@PUT
	@Consumes(MediaType.APPLICATION_XML)
	public Response putCas(JAXBElement<Cas> casElement) {
		Cas cas = casElement.getValue();
		Response response;
		if (casService.getCass().containsKey(cas.getId())) {
			response = Response.noContent().build();
		} else {
			response = Response.created(uriInfo.getAbsolutePath()).build();
		}
		casService.createCas(cas);
		return response;
	}

	@DELETE
	public void deleteCas() {
		casService.deleteCas(id);
	}

}