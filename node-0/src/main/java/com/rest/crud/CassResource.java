package com.rest.crud;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;

@Path("/cass")
public class CassResource {

	@Context
	UriInfo uriInfo;
	@Context
	Request request;

	CasService casService;

	public CassResource() {
		casService = new CasService();
	}

	@GET
	@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
	public List<Cas> getCass() {
		return casService.getCasAsList();
	}

	@GET
	@Produces(MediaType.TEXT_XML)
	public List<Cas> getCassAsHtml() {
		return casService.getCasAsList();
	}

	// URI: /rest/cass/count
	@GET
	@Path("count")
	@Produces(MediaType.TEXT_PLAIN)
	public String getCount() {
		return String.valueOf(casService.getCassCount());
	}

	@POST
	@Produces(MediaType.TEXT_HTML)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public void createCas(@FormParam("id") String id,
			@FormParam("resurl") String url,
			@FormParam("restoken") String token,
			@Context HttpServletResponse servletResponse) throws IOException {
		Cas cas = new Cas(id, url, token);
		casService.createCas(cas);
		servletResponse.sendRedirect("./cass/");
	}

	@Path("{cas}")
	public CasResource getCas(@PathParam("cas") String id) {
		return new CasResource(uriInfo, request, id);
	}

}