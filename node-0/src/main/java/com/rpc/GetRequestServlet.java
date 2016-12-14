package com.rpc;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetRequestServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		handleRequest(req, res);
	}

        public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
                handleRequest(req, res);
        }

	public void handleRequest(HttpServletRequest req, HttpServletResponse res) throws IOException {

		PrintWriter out = res.getWriter();
		res.setContentType("text/plain");

		String paramName = "parameter1";
		String paramValue = req.getParameter(paramName);

		out.write(paramName);
		out.write(" = ");
		out.write(paramValue);
		out.write("\n");

		paramName = "UNKNOWN";
		paramValue = req.getParameter(paramName);

		if (paramValue==null) {
			out.write("Parameter " + paramName + " not found");
		}
		out.close();
	}
}
