package mall;

import java.sql.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.*;

public class MallDAO {
	// 업체목록 출력
	public JSONObject list(SqlVO vo) {
		JSONObject jObject = new JSONObject();
		try {
			String sql = "{call list(?,?,?,?,?,?,?)}";
			CallableStatement cs = Database.CON.prepareCall(sql);
			cs.setString(1, "mall");
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
				obj.put("m_id", rs.getString("m_id"));
				obj.put("m_name", rs.getString("m_name"));
				obj.put("manager", rs.getString("manager"));
				obj.put("address", rs.getString("address"));
				obj.put("tel", rs.getString("tel"));
				obj.put("email", rs.getString("email"));
				jArray.add(obj);
			}
			jObject.put("mallList", jArray);
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
	//업체 등록 
	public int insert(MallVO vo)  {
	      int count=-1;
	      try {
	         String sql="call add_mall(?,?,?,?,?,?,?)";
	         CallableStatement cs = Database.CON.prepareCall(sql);
	         cs.setString(1, vo.getM_id());
	         cs.setString(2, vo.getM_name());
	         cs.setString(3, vo.getManager());
	         cs.setString(4, vo.getAddress());
	         cs.setString(5, vo.getTel());
	         cs.setString(6, vo.getEmail());
	         cs.registerOutParameter(7, oracle.jdbc.OracleTypes.INTEGER);
	         cs.execute();
	         count=cs.getInt(7);
	         
	      }catch(Exception e) {
	         System.out.println("업체추가 에러 : "+e.toString());
	      }
	      return count;
	      
	   }
	
	//업체 정보
	   public JSONObject read(String m_id) {
	      JSONObject obj = new JSONObject();
	      try {
	         String sql="select * from mall where m_id=?";
	         PreparedStatement ps=Database.CON.prepareStatement(sql);
	         ps.setString(1,m_id);
	         ResultSet rs=ps.executeQuery();
	            if (rs.next()) {               
	               obj.put("m_id", rs.getString("m_id"));
	               obj.put("m_name", rs.getString("m_name"));
	               obj.put("manager", rs.getString("manager"));
	               obj.put("address", rs.getString("address"));
	               obj.put("tel", rs.getString("tel"));
	               obj.put("email", rs.getString("email"));
	            }
	      }catch(Exception e) {
	         System.out.println("업체읽기  : "+e.toString());
	      }
	      return obj;
	   }
	   
	   
	   //업체 수정 
	   public void update(MallVO vo)  {
	      try {
	         String sql="update mall set m_name=?,manager=?,address=?,tel=?,email=? where m_id=?";
	         PreparedStatement ps=Database.CON.prepareStatement(sql);
	         ps.setString(1, vo.getM_name());
	         ps.setString(2, vo.getManager());
	         ps.setString(3, vo.getAddress());
	         ps.setString(4, vo.getTel());
	         ps.setString(5, vo.getEmail());
	         ps.setString(6, vo.getM_id());
	         ps.execute();
	      }catch(Exception e) {
	         System.out.println("업체수정 : "+e.toString());
	      }
	   
	   }
	   //업체 삭제 
	   public int delete(String m_id)  {
	      int count=-1;
	      try {
	         String sql="call del_mall(?,?)";
	         CallableStatement cs = Database.CON.prepareCall(sql);
	         cs.setString(1, m_id);
	         cs.registerOutParameter(2, oracle.jdbc.OracleTypes.INTEGER);
	         cs.execute();
	         count=cs.getInt(2);   
	      }catch(Exception e) {
	         System.out.println("업체삭제  : "+e.toString());
	      }
	      return count;
	      
	   }

}
