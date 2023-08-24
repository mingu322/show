package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.OrderVO;
import model.PurchaseDAO;
import model.PurchaseVO;
import model.UserVO;

@WebServlet(value={"/purchase/insert", "/order/insert", "/purchase/list.json", "/purchase/list", 
		"/purchase/total", "/purchase/read", "/purchase/update", "/purchase/user"})
public class PurchaseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    PurchaseDAO dao=new PurchaseDAO();   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/purchase/list.json": //실행 /purchase/list.json?page=1&key=pid&query=
			String key=request.getParameter("key");
			String query=request.getParameter("query");
			int page=Integer.parseInt(request.getParameter("page"));
			Gson gson=new Gson();
			out.println(gson.toJson(dao.list(key, query, page)));
			break;
			
		case "/purchase/list":
			request.setAttribute("pageName", "/purchase/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/purchase/total": //실행: /purchase/total?key=pid&query=
			key=request.getParameter("key");
			query=request.getParameter("query");
			out.println(dao.total(key, query));
			break;
			
		case "/purchase/read":
			String pid=request.getParameter("pid");
			request.setAttribute("vo", dao.read(pid));
			request.setAttribute("array", dao.list(pid));
			request.setAttribute("pageName", "/purchase/read.jsp");
			dis.forward(request, response);
			break;
			
		case "/purchase/user":
			HttpSession session=request.getSession();
			UserVO user=(UserVO)session.getAttribute("user");
			request.setAttribute("array", dao.user(user.getUid()));
			request.setAttribute("pageName", "/purchase/user.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		switch(request.getServletPath()) {
		case "/purchase/insert":
			PurchaseVO vo=new PurchaseVO();
			UUID uuid=UUID.randomUUID();
			String pid=uuid.toString().substring(0,13);
			vo.setPid(pid);
			vo.setUid(request.getParameter("uid"));
			vo.setAddress1(request.getParameter("address1"));
			vo.setAddress2(request.getParameter("address2"));
			vo.setPhone(request.getParameter("phone"));
			vo.setPurSum(Integer.parseInt(request.getParameter("sum")));
			System.out.println(vo.toString());
			dao.insert(vo); //구매정보저장
			out.print(pid);
			break;
		case "/order/insert":
			OrderVO ovo=new OrderVO();
			ovo.setPid(request.getParameter("pid"));
			ovo.setGid(request.getParameter("gid"));
			ovo.setPrice(Integer.parseInt(request.getParameter("price")));
			ovo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			System.out.println(ovo.toString());
			dao.insert(ovo); //주문상품저장
			break;
		case "/purchase/update":
			pid=request.getParameter("pid");
			int status=Integer.parseInt(request.getParameter("status"));
			dao.update(pid, status);
			break;
		}
	}

}