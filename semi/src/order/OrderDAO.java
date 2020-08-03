package order;

import java.sql.CallableStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.Database;
import database.SqlVO;

public class OrderDAO {
	//주문목록 출력
		public JSONObject list(SqlVO vo, String u_id) {
			JSONObject jObject = new JSONObject();
			try {
				String sql = "{call order_list(?,?,?,?,?,?,?)}";
				CallableStatement cs = Database.CON.prepareCall(sql);
				cs.setString(1, vo.getKey());
				cs.setString(2, vo.getWord());
				cs.setString(3, vo.getOrder());
				cs.setString(4, vo.getDesc());
				cs.setInt(5, vo.getPage());
				cs.setInt(6, vo.getPerPage());
				cs.setString(7, u_id);
				cs.execute();
				ResultSet rs = cs.getResultSet();

				JSONArray jArray = new JSONArray();
				while (rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("o_id", rs.getString("o_id"));
					obj.put("p_id", rs.getString("p_id"));
					obj.put("pr_name", rs.getString("prname"));
					obj.put("pu_name", rs.getString("puname"));
					obj.put("company", rs.getString("company"));
					obj.put("image", rs.getString("image"));
					obj.put("price", rs.getInt("price"));
					obj.put("quantity", rs.getString("quantity"));
					jArray.add(obj);
				}
				jObject.put("orderList", jArray);
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
				System.out.println(e.toString());
			}
			return jObject;
		}
		//주문취소
	      public int delete(String o_id, String p_id) {
	         int count=-1;
	         try {
	            String sql="{call del_purchase_orders(?,?,?)}";
	            CallableStatement cs=Database.CON.prepareCall(sql);
	            cs.setString(1, o_id);
	            cs.setString(2, p_id);
	            cs.registerOutParameter(3, java.sql.Types.INTEGER);
	            cs.execute();
	            count=cs.getInt(3); //count가'0'이면 처리상태가 완료라 주문취소 불가 count'1'이면 취소성공임
	         }catch(Exception e) {
	            System.out.println("주문취소"+e.toString());
	         }
	         return count;
	      }
	      

}
