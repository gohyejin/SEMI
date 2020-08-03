package mall;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import database.SqlVO;

@WebServlet(value = { "/mall/list", "/mall/insert", "/mall/read", "/mall/update", "/mall/delete" })
public class MallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		SqlVO vo = new SqlVO();
		MallDAO mdao = new MallDAO();
		String key = request.getParameter("key") == null ? "m_id" : request.getParameter("key");
		String word = request.getParameter("word") == null ? "" : request.getParameter("word");
		String strPage = request.getParameter("page") == null ? "1" : request.getParameter("page");
		int page = Integer.parseInt(strPage);
		String strPerPage = request.getParameter("perPage") == null ? "5" : request.getParameter("perPage");
		int perPage = Integer.parseInt(strPerPage);
		String order = request.getParameter("order") == null ? "m_id" : request.getParameter("order");
		String desc = request.getParameter("desc") == null ? "" : request.getParameter("desc");

		vo.setKey(key);
		vo.setWord(word);
		vo.setPage(page);
		vo.setPerPage(perPage);
		vo.setOrder(order);
		vo.setDesc(desc);
		switch (request.getServletPath()) {
		case "/mall/list":
			out.println(mdao.list(vo));
			break;
		case "/mall/read":
			String m_id = request.getParameter("m_id");
			out.println(mdao.read(m_id));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		MallVO vo = new MallVO();
		MallDAO mdao = new MallDAO();
		vo.setM_id(request.getParameter("m_id"));
		vo.setM_name(request.getParameter("m_name"));
		vo.setManager(request.getParameter("manager"));
		vo.setAddress(request.getParameter("address"));
		vo.setTel(request.getParameter("tel"));
		vo.setEmail(request.getParameter("email"));
		JSONObject jObject = new JSONObject();
		switch (request.getServletPath()) {
			case "/mall/insert":
				jObject.put("count", mdao.insert(vo));
				out.println(jObject);
				break;
			case "/mall/update":
				mdao.update(vo);
				break;
			case "/mall/delete":
				jObject.put("count", mdao.delete(vo.getM_id()));
				out.println(jObject);
				break;
		}

	}

}
