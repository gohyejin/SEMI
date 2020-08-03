package product;

import java.io.File;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import database.SqlVO;

@WebServlet(value= {"/prod/searchList","/prod/bestList","/prod/list","/prod/FList","/prod/IList","/prod/SList","/prod/DList","/prod/UList","/prod/read","/prod/insert","/prod/delete","/prod/update"})
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
		 RequestDispatcher dis=null;
		   PrintWriter out = response.getWriter();
		   ProductDAO pdao = new ProductDAO();
		   SqlVO vo = new SqlVO();
		   String key=request.getParameter("key")==null?"p_id":request.getParameter("key");
		   String word=request.getParameter("word")==null?"":request.getParameter("word");
		   String strPage=request.getParameter("page")==null?"1":request.getParameter("page");
		   int page=Integer.parseInt(strPage);
		   String strPerPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
		   int perPage=Integer.parseInt(strPerPage);
		   String order=request.getParameter("order")==null?"p_id":request.getParameter("order");
		   String desc=request.getParameter("desc")==null?"":request.getParameter("desc");

		   vo.setKey(key);
		   vo.setWord(word);
		   vo.setPage(page);
		   vo.setPerPage(perPage);
		   vo.setOrder(order);
		   vo.setDesc(desc);
		   switch(request.getServletPath()) {
		   case "/prod/list" :
			   out.println(pdao.list(vo));
			   break;
		   case "/prod/FList" :
			   out.println(pdao.FList(vo));
			   break;
		   case "/prod/IList" :
			   out.println(pdao.IList(vo));
			   break;
		   case "/prod/DList" :
			   out.println(pdao.DList(vo));
			   break;
		   case "/prod/SList" :
			   out.println(pdao.SList(vo));
			   break;
		   case "/prod/UList" :
			   out.println(pdao.UList(vo));
			   break;
	         case "/prod/read":
	           ProductVO pvo = pdao.read(request.getParameter("p_id"));
	           request.setAttribute("pvo", pvo);
	           dis=request.getRequestDispatcher("read.jsp");
	           dis.forward(request, response);
	             break;
	         case "/prod/searchList" :
	        	 HttpSession session = request.getSession();
                 session.setAttribute("word", vo.getWord());
	             out.println(pdao.searchList(vo));
	             
	             break;
	          case "/prod/bestList" :
	             out.println(pdao.bestList());
	             break;
	          case "/prod/insert" :
	              String u_id=request.getParameter("u_id");
	                String p_id = request.getParameter("p_id");
	                String strQuantity=request.getParameter("quantity");
	                int quantity=Integer.parseInt(strQuantity);
	                pdao.cartInsert(u_id,p_id,quantity); 
	                break;
		   }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		JSONObject jObject = new JSONObject();
		PrintWriter out = response.getWriter();
		ProductDAO pdao = new ProductDAO();
		ProductVO vo = new ProductVO();
		// 이미지파일 업로드
		String uploadPath = "c:" + File.separator + "semi" + File.separator + "product" + File.separator;
		File mdPath = new File(uploadPath);
		if (!mdPath.exists())
			mdPath.mkdir();
		MultipartRequest multi = new MultipartRequest(request, uploadPath, 1024 * 1024 * 10, "UTF-8",
				new DefaultFileRenamePolicy());
		String image = multi.getFilesystemName("image");
		String p_id = multi.getParameter("p_id");
		vo.setP_id(p_id);
		vo.setP_name(multi.getParameter("p_name"));
		vo.setM_id(multi.getParameter("m_id"));
		vo.setCompany(multi.getParameter("company"));
		vo.setPrice(Integer.parseInt(multi.getParameter("price")));
		vo.setDetail(multi.getParameter("detail"));

		switch (request.getServletPath()) {
		case "/prod/insert":
			vo.setImage(image);
			pdao.insert(vo);
			break;
		case "/prod/delete":
			jObject.put("count", pdao.delete(vo.getP_id()));
			out.println(jObject);
			break;
		case "/prod/update":
			ProductVO oldVO = pdao.read(p_id);
			if (image != null) {
				if (oldVO.getImage() != null) {
					System.gc();
					File oldImage = new File(uploadPath + oldVO.getImage());
					oldImage.delete();
				}

				vo.setImage(image);
			} else {
				vo.setImage(oldVO.getImage());
			}
			pdao.update(vo);
			response.sendRedirect("/semi/shop.jsp");
			break;
		}

	}

}
