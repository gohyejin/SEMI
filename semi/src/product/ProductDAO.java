package product;

import java.sql.*;

import org.json.simple.*;

import database.*;

public class ProductDAO {
	// 베스트상품 목록출력 5개
	   public JSONObject bestList() {
	      JSONObject jObject = new JSONObject();
	      try {
	         String sql = "select o.p_id,p.* , sum(o.quantity) ctot from orders o, product p where o.p_id=p.p_id group by o.p_id order by ctot desc limit 0,5";
	         PreparedStatement ps = Database.CON.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery();
	         JSONArray jArray = new JSONArray();
	         while (rs.next()) {
	            JSONObject obj = new JSONObject();
	            obj.put("p_id", rs.getString("p_id"));
	            obj.put("p_name", rs.getString("p_name"));
	            obj.put("image", rs.getString("image"));
	            jArray.add(obj);
	         }
	         jObject.put("array", jArray);
	      } catch (Exception e) {
	         System.out.println("베스트상품목록 출력" + e.toString());
	      }
	      return jObject;
	   }

	   // 전체상품 검색
	   public JSONObject searchList(SqlVO vo) {
	      JSONObject jObject = new JSONObject();
	      try {
	         String sql = "{call product_list_all(?,?,?,?,?)}";
	         CallableStatement cs = Database.CON.prepareCall(sql);
	         cs.setString(1, vo.getWord());
	         cs.setString(2, vo.getOrder());
	         cs.setString(3, vo.getDesc());
	         cs.setInt(4, vo.getPage());
	         cs.setInt(5, vo.getPerPage());
	         cs.execute();
	         ResultSet rs = cs.getResultSet();
	         JSONArray jArray = new JSONArray();
	         while (rs.next()) {
	            JSONObject obj = new JSONObject();
	            obj.put("p_id", rs.getString("p_id"));
	            obj.put("p_name", rs.getString("p_name"));
	            obj.put("company", rs.getString("company"));
	            obj.put("price", rs.getInt("price"));
	            obj.put("detail", rs.getString("detail"));
	            obj.put("image", rs.getString("image"));
	            obj.put("quantity", rs.getInt("quantity"));
	            jArray.add(obj);
	         }
	         jObject.put("searchList", jArray);

	         cs.getMoreResults();

	         rs = cs.getResultSet();

	         int count = 0;
	         if (rs.next()) {
	            count = rs.getInt("total");
	         }

	         jObject.put("count", count);
	         jObject.put("perPage", vo.getPerPage());
	         jObject.put("page", vo.getPage());

	         int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
	         jObject.put("totPage", totPage);
	      } catch (Exception e) {
	         System.out.println("전체상품검색" + e.toString());
	      }
	      return jObject;
	   }
	
	// 전체상품목록 출력
	public JSONObject list(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call list(?,?,?,?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "(select p.*,m.m_name from product p, mall m where p.m_id=m.m_id) tbl");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());

			cs.execute();
			ResultSet rs = cs.getResultSet();

			JSONArray jArray = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("m_name", rs.getString("m_name"));
				obj.put("p_id", rs.getString("p_id"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price", rs.getInt("price"));
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("quantity", rs.getInt("quantity"));
				jArray.add(obj);
			}
			jObject.put("ProdList", jArray);
			cs.getMoreResults();

			rs = cs.getResultSet();

			int count = 0;
			if (rs.next()) {
				count = rs.getInt("total");
			}

			jObject.put("count", count);
			jObject.put("perPage", vo.getPerPage());
			jObject.put("page", vo.getPage());

			int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
			jObject.put("totPage", totPage);

		} catch (Exception e) {
			System.out.println("전체상품목록 출력" + e.toString());
		}
		return jObject;
	}

	// 과일목록 출력
	public JSONObject FList(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call list(?,?,?,?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "(select p.*,m.m_name from flist p, mall m where p.m_id=m.m_id) tbl");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());

			cs.execute();
			ResultSet rs = cs.getResultSet();

			JSONArray jArray = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("m_name", rs.getString("m_name"));
				obj.put("p_id", rs.getString("p_id"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price", rs.getInt("price"));
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("quantity", rs.getInt("quantity"));
				jArray.add(obj);
			}
			jObject.put("ProdFList", jArray);
			cs.getMoreResults();

			rs = cs.getResultSet();

			int count = 0;
			if (rs.next()) {
				count = rs.getInt("total");
			}

			jObject.put("count", count);
			jObject.put("perPage", vo.getPerPage());
			jObject.put("page", vo.getPage());

			int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
			jObject.put("totPage", totPage);

		} catch (Exception e) {
			System.out.println("과일목록 출력" + e.toString());
		}
		return jObject;
	}

	// 냉동식품목록 출력
	public JSONObject IList(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call list(?,?,?,?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "(select p.*,m.m_name from ilist p, mall m where p.m_id=m.m_id) tbl");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());

			cs.execute();
			ResultSet rs = cs.getResultSet();

			JSONArray jArray = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("m_name", rs.getString("m_name"));
				obj.put("p_id", rs.getString("p_id"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price", rs.getInt("price"));
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("quantity", rs.getInt("quantity"));
				jArray.add(obj);
			}
			jObject.put("ProdIList", jArray);
			cs.getMoreResults();

			rs = cs.getResultSet();

			int count = 0;
			if (rs.next()) {
				count = rs.getInt("total");
			}

			jObject.put("count", count);
			jObject.put("perPage", vo.getPerPage());
			jObject.put("page", vo.getPage());

			int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
			jObject.put("totPage", totPage);

		} catch (Exception e) {
			System.out.println("냉동식품목록 출력" + e.toString());
		}
		return jObject;
	}

	// 음료목록 출력
	public JSONObject DList(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call list(?,?,?,?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "(select p.*,m.m_name from dlist p, mall m where p.m_id=m.m_id) tbl");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());

			cs.execute();
			ResultSet rs = cs.getResultSet();

			JSONArray jArray = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("m_name", rs.getString("m_name"));
				obj.put("p_id", rs.getString("p_id"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price", rs.getInt("price"));
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("quantity", rs.getInt("quantity"));
				jArray.add(obj);
			}
			jObject.put("ProdDList", jArray);
			cs.getMoreResults();

			rs = cs.getResultSet();

			int count = 0;
			if (rs.next()) {
				count = rs.getInt("total");
			}

			jObject.put("count", count);
			jObject.put("perPage", vo.getPerPage());
			jObject.put("page", vo.getPage());

			int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
			jObject.put("totPage", totPage);

		} catch (Exception e) {
			System.out.println("음료목록 출력" + e.toString());
		}
		return jObject;
	}

	// 간식목록 출력
	public JSONObject SList(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call list(?,?,?,?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "(select p.*,m.m_name from slist p, mall m where p.m_id=m.m_id) tbl");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());

			cs.execute();
			ResultSet rs = cs.getResultSet();

			JSONArray jArray = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("m_name", rs.getString("m_name"));
				obj.put("p_id", rs.getString("p_id"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price", rs.getInt("price"));
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("quantity", rs.getInt("quantity"));
				jArray.add(obj);
			}
			jObject.put("ProdSList", jArray);
			cs.getMoreResults();

			rs = cs.getResultSet();

			int count = 0;
			if (rs.next()) {
				count = rs.getInt("total");
			}

			jObject.put("count", count);
			jObject.put("perPage", vo.getPerPage());
			jObject.put("page", vo.getPage());

			int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
			jObject.put("totPage", totPage);

		} catch (Exception e) {
			System.out.println("간식목록 출력" + e.toString());
		}
		return jObject;
	}

	// 특별상품목록 출력
	public JSONObject UList(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "call list(?,?,?,?,?,?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "(select p.*,m.m_name from ulist p, mall m where p.m_id=m.m_id) tbl");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());

			cs.execute();
			ResultSet rs = cs.getResultSet();

			JSONArray jArray = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("m_name", rs.getString("m_name"));
				obj.put("p_id", rs.getString("p_id"));
				obj.put("p_name", rs.getString("p_name"));
				obj.put("company", rs.getString("company"));
				obj.put("price", rs.getInt("price"));
				obj.put("detail", rs.getString("detail"));
				obj.put("image", rs.getString("image"));
				obj.put("quantity", rs.getInt("quantity"));
				jArray.add(obj);
			}
			jObject.put("ProdUList", jArray);
			cs.getMoreResults();

			rs = cs.getResultSet();

			int count = 0;
			if (rs.next()) {
				count = rs.getInt("total");
			}

			jObject.put("count", count);
			jObject.put("perPage", vo.getPerPage());
			jObject.put("page", vo.getPage());

			int totPage = count % vo.getPerPage() == 0 ? count / vo.getPerPage() : count / vo.getPerPage() + 1;
			jObject.put("totPage", totPage);

		} catch (Exception e) {
			System.out.println("특별상품목록 출력" + e.toString());
		}
		return jObject;
	}

	// 상품수정
	public void update(ProductVO vo) {
		try {
			String sql = "update product set image=? where p_id=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getImage());
			ps.setString(2, vo.getP_id());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품 수정:" + e.toString());
		}
	}

	// 상품삭제
	public int delete(String p_id) {
		int count = -1;
		try {
			String sql = "call del_product(?,?)";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, p_id);
			cs.registerOutParameter(2, java.sql.Types.INTEGER);
			cs.execute();
			count = cs.getInt(2);
		} catch (Exception e) {
			System.out.println("상품삭제:" + e.toString());
		}
		return count;
	}

	// 상품정보읽기
	public ProductVO read(String p_id) {
		ProductVO vo = new ProductVO();
		try {
			String sql = "select * from product where p_id=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, p_id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				vo.setP_id(rs.getString("p_id"));
				vo.setP_name(rs.getString("p_name"));
				vo.setM_id(rs.getString("m_id"));
				vo.setCompany(rs.getString("company"));
				vo.setPrice(rs.getInt("price"));
				vo.setDetail(rs.getString("detail"));
				vo.setImage(rs.getString("image"));
				vo.setImage1(rs.getString("image1"));
			}
		} catch (Exception e) {
			System.out.println("상품 정보읽기:" + e.toString());
		}
		return vo;

	}
	
	 //장바구니에 담기
    public void cartInsert(String u_id, String p_id, int quantity) {
       try {
          String sql="{call add_readcart(?,?,?)}";
          CallableStatement cs=Database.CON.prepareCall(sql);
          cs.setString(1, u_id);
          cs.setString(2, p_id);
          cs.setInt(3, quantity);
          cs.execute();
       }catch(Exception e) {
          System.out.println("cartinsert"+e.toString());
       }
    }


	// 상품 등록
	public void insert(ProductVO vo) {
		try {
			String sql = "insert into product(p_id,p_name,m_id,company,price,detail,image) values(?,?,?,?,?,?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getP_id());
			ps.setString(2, vo.getP_name());
			ps.setString(3, vo.getM_id());
			ps.setString(4, vo.getCompany());
			ps.setInt(5, vo.getPrice());
			ps.setString(7, vo.getDetail());
			ps.setString(8, vo.getImage());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품 등록:" + e.toString());
		}
	}

}
