package order;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import database.SqlVO;

@WebServlet(value = {"/order/list","/order/delete"})
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		   PrintWriter out = response.getWriter();
		   SqlVO vo = new SqlVO();
		   OrderDAO odao = new OrderDAO();
		   String key=request.getParameter("key")==null?"o_id":request.getParameter("key");
		   String word=request.getParameter("word")==null?"":request.getParameter("word");
		   String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
		   int page=Integer.parseInt(strPage);
		   String strPerPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
		   int perPage=Integer.parseInt(strPerPage);
		   String order=request.getParameter("order")==null?"o_id":request.getParameter("order");
		   String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

		   vo.setKey(key);
		   vo.setWord(word);
		   vo.setPage(page);
		   vo.setPerPage(perPage);
		   vo.setOrder(order);
		   vo.setDesc(desc);
		   switch(request.getServletPath()) {
		   case "/order/list" :
			   HttpSession session = request.getSession();
			   String u_id = (String)session.getAttribute("u_id");
			   out.println(odao.list(vo,u_id));
			   break;
		   }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
	      OrderDAO odao = new OrderDAO();      
	      JSONObject jObject=new JSONObject();
	      switch(request.getServletPath()) {
	       case "/order/delete" :
	          String o_id=request.getParameter("o_id");
	          String p_id=request.getParameter("p_id");
	          
	          jObject.put("count", odao.delete(o_id, p_id));//count가'0'이면 처리상태가 완료라 주문취소 불가 count'1'이면 취소성공임
	          out.println(jObject);
	          break;
	       }

	}

}
