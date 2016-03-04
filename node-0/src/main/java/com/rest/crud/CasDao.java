package com.rest.crud;

import java.util.HashMap;
import java.util.Map;

public enum CasDao {
	instance;

	private Map<String, Cas> cass = new HashMap<String, Cas>();

	private CasDao() {

		//default data
		Cas cas = new Cas("87819b12d267500ffc93c4b69e0a37d4f44feec0",
			"http://node-0:8080/cas/default1.txt","default");
		cass.put("87819b12d267500ffc93c4b69e0a37d4f44feec0", cas);
		cas = new Cas("418c60ae5d02aa7fc1e669eedb7741873ce6b9a2",
			"http://node-0:8080/cas/default2.txt","default");
		cass.put("418c60ae5d02aa7fc1e669eedb7741873ce6b9a2", cas);

	}

	public Map<String, Cas> getCass() {
		return cass;
	}

}
