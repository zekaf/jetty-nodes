package com.rest.crud;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Cas {
	private String id;
	private String url;
	private String token;

	public Cas() {

	}

	public Cas(String id, String url, String token) {
		super();
		this.id = id;
		this.url = url;
		this.token = token;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

}