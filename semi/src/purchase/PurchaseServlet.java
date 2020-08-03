package purchase;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import database.*;
import order.OrderVO;

@WebServlet(value= {"/purchase/list","/purchase/read","/purchase/insert","/purchase/update","/purchase/id"})
public class PurchaseServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         PurchaseDAO pdao = new PurchaseDAO();
         PurchaseVO vo=new PurchaseVO();
         SqlVO svo = new SqlVO();
         
         JSONObject jObject= new JSONObject();
         String key=request.getParameter("key")==null?"o_id":request.getParameter("key");
         String word=request.getParameter("word")==null?"":request.getParameter("word");
         String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
         int page=Integer.parseInt(strPage);
         String strPerPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
         int perPage=Integer.parseInt(strPerPage);
         String order=request.getParameter("order")==null?"o_id":request.getParameter("order");
         String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
        
         svo.setKey(key);
         svo.setWord(word);
         svo.setPage(page);
         svo.setPerPage(perPage);
         svo.setOrder(order);
         svo.setDesc(desc);
         switch(request.getServletPath()) {
         case "/purchase/list" :
               HttpSession session = request.getSession();
               String u_id =(String) session.getAttribute("u_id");
            out.println(pdao.list(svo,u_id));
            break;
         case "/purchase/read":
              vo = pdao.read(request.getParameter("o_id"));
              jObject = new JSONObject();
             jObject.put("o_id", vo.getO_id());
             jObject.put("u_id", vo.getU_id());
             jObject.put("address", vo.getAddress());
             jObject.put("tel", vo.getTel());
             jObject.put("p_name", vo.getP_name());
             jObject.put("payType",vo.getPayType());
             jObject.put("status", vo.getStatus());
             out.println(jObject);
            break;
         case "/purchase/id" :
             jObject.put("o_id", pdao.getO_id());
             out.println(jObject);
             break;
    
         }
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
           JSONObject jObject=new JSONObject();
         PrintWriter out=response.getWriter();
         PurchaseVO vo = new PurchaseVO();
         PurchaseDAO pdao = new PurchaseDAO();
         OrderVO ovo = new OrderVO();
         HttpSession session = request.getSession();
         String o_id=request.getParameter("o_id");
         String u_id=request.getParameter("u_id");
         String p_name=request.getParameter("p_name");
         String address=request.getParameter("address");
         String tel=request.getParameter("tel");
         String payType=request.getParameter("payType");
         String status=request.getParameter("status");
         switch(request.getServletPath()) {
         case "/purchase/insert":
             ovo.setO_id(pdao.getO_id());
             jObject.put("o_id", ovo.getO_id());
             System.out.println(ovo.getO_id());
             ovo.setU_id((String)session.getAttribute("u_id"));
             ovo.setAddress(request.getParameter("address"));
             ovo.setTel(request.getParameter("tel"));
             ovo.setPayType(request.getParameter("payType"));
             ovo.setP_name(request.getParameter("p_name"));
             ovo.setP_id(request.getParameter("p_id"));
             ovo.setPrice(Integer.parseInt(request.getParameter("price")));
             ovo.setQuantity(Integer.parseInt(request.getParameter("quantity")));
             jObject.put("count", pdao.insert(ovo));
             out.print(jObject);
             break;
          
         case "/purchase/update":
              vo.setO_id(o_id);
              vo.setP_name(p_name);
              vo.setAddress(address);
              vo.setTel(tel);
              vo.setPayType(payType);
              vo.setStatus(status);
              pdao.update(vo);
            break;
   }
   }
}