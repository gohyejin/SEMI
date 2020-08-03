package cart;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.SqlVO;

@WebServlet(value = {"/cart/list", "/cart/insert", "/cart/delete", "/cart/update"})
public class CartServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         SqlVO vo = new SqlVO();
         CartVO cvo = new CartVO();
         CartDAO cdao = new CartDAO();
         String key=request.getParameter("key")==null?"u_id":request.getParameter("key");
         String word=request.getParameter("word")==null?"":request.getParameter("word");
         String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
         int page=Integer.parseInt(strPage);
         String strPerPage=request.getParameter("perPage")==null?"100":request.getParameter("perPage");
         int perPage=Integer.parseInt(strPerPage);
         String order=request.getParameter("order")==null?"u_id":request.getParameter("order");
         String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

         vo.setKey(key);
         vo.setWord(word);
         vo.setPage(page);
         vo.setPerPage(perPage);
         vo.setOrder(order);
         vo.setDesc(desc);
         
         switch(request.getServletPath()) {
         case "/cart/list" :
             HttpSession session = request.getSession();
             session.setAttribute("quantity", cvo.getQuantity());
			 session.setAttribute("price", cvo.getPrice());
             String u_id = (String) session.getAttribute("u_id");
             out.println(cdao.list(vo,u_id));
             break;
         case "/cart/update" :
             u_id=request.getParameter("u_id");
             String p_id=request.getParameter("p_id");
              cdao.update1(u_id, p_id);
              break;
              
         }
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      PrintWriter out = response.getWriter();
      CartDAO cdao = new CartDAO();
      CartVO cvo=new CartVO();
      
      cvo.setU_id(request.getParameter("u_id"));
      cvo.setP_id(request.getParameter("p_id"));
      cvo.setImage(request.getParameter("image"));
      
      switch(request.getServletPath()) {
      case "/cart/insert" :
         cdao.insert(cvo);
         break;
      case "/cart/delete" :
    	  String u_id = request.getParameter("u_id");
    	  String p_id = request.getParameter("p_id");
         cdao.delete(u_id, p_id);
         break;
      case "/cart/update" :
          u_id=request.getParameter("u_id");
          p_id=request.getParameter("p_id");
           cdao.update(u_id, p_id);
           break;
      }
   }

}