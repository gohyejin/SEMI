package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet(value = {"/user/login","/user/logout","/user/read","/user/delete","/user/insert","/user/check"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		UserDAO udao = new UserDAO();
		PrintWriter out = response.getWriter();
		switch (request.getServletPath()) {
		case "/user/logout":
			System.out.println("�α׾ƿ�!");
			HttpSession session = request.getSession();
			session.invalidate();/*�α׾ƿ� �� ������ Ŭ�����Ŵ*/
			response.sendRedirect("/semi/index.jsp");
			break;
		  case "/user/read" :
	         String u_id = request.getParameter("u_id");
	         out.print(udao.read(u_id));
	         RequestDispatcher dis=request.getRequestDispatcher("mypage.jsp");
	         dis.forward(request, response);
	         break;
		  case "/user/check" :
	           out.println(udao.read(request.getParameter("id")));
	           break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String u_id = request.getParameter("u_id");
		String pass = request.getParameter("pass");
		UserDAO udao = new UserDAO();
		UserVO vo = new UserVO();
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
        HttpSession session = request.getSession();/*�������� ��밡��*/
		switch (request.getServletPath()) {
		 case "/user/login" :
	         System.out.println("�α���!");
	         vo = udao.login(u_id);
	         int check = 0;/*id�� ���� ���*/
	            if(vo.getU_id()!=null) {/*id�� �ִ� ���*/
	               if(vo.getPass().equals(pass)){
	                  if(vo.getDel_user()==0) {
	                     check=2; /*pass�� ��ġ�ϴ� ���*/
	                     session.setAttribute("u_id", vo.getU_id());
	                     session.setAttribute("pass", vo.getPass());
	                     session.setAttribute("address", vo.getAddress());
	                     session.setAttribute("tel", vo.getTel());
	                     session.setAttribute("email", vo.getEmail());
	                     session.setAttribute("image", vo.getImage());
	                  }else {
	                     check=3;/*Ż���� ȸ���� ���*/
	                  }
	               }else {
	                  check=1; /*pass�� ��ġ�����ʴ� ���*/
	               }
	            }
	             session.setAttribute("u_name", vo.getU_name());
	         obj.put("check", check);
	         out.println(obj);
	         
	         break;
		case "/user/update":
			udao.update(vo);
			break;
		case "/user/delete":
			udao.delete(u_id);
			break;
		case "/user/insert" :
		      JSONObject jObject=new JSONObject();
		      vo.setU_id(request.getParameter("u_id"));
		        vo.setPass(request.getParameter("pass"));
		        vo.setU_name(request.getParameter("u_name"));
		        vo.setAddress(request.getParameter("address"));
		        vo.setTel(request.getParameter("tel"));
		        vo.setEmail(request.getParameter("email"));
		       jObject.put("count",udao.insert(vo));
		        out.println(jObject);
		        
		        break;
		
		}
	}

}
