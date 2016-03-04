package com.rest.crud;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CasService {

	CasDao casDao;

	public CasService() {
		casDao = CasDao.instance;
	}

	public void createCas(Cas cas) {
		casDao.getCass().put(cas.getId(), cas);
	}

	public Cas getCas(String id) {
		return casDao.getCass().get(id);
	}

	public Map<String, Cas> getCass() {
		return casDao.getCass();
	}

	public List<Cas> getCasAsList() {
		List<Cas> casList = new ArrayList<Cas>();
		casList.addAll(casDao.getCass().values());
		return casList;
	}

	public int getCassCount() {
		return casDao.getCass().size();
	}

	public void deleteCas(String id) {
		casDao.getCass().remove(id);
	}

}
