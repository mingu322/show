package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FavoriteDAO;

@WebServlet(value={"/favorite/read", "/favorite/insert", "/favorite/delete"})
public class FavoritController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    FavoriteDAO dao=new FavoriteDAO();   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String uid=request.getParameter("uid");
		String gid=request.getParameter("gid");
		
		switch(request.getServletPath()) {
		case "/favorite/read":	
			out.println(dao.read(gid, uid));
			break;
		case "/favorite/insert":
			dao.insert(gid, uid);
			break;
		case "/favorite/delete":
			dao.delete(gid, uid);
			break;
		}
	}
}