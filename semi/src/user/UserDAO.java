package user;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONObject;

import database.Database;

public class UserDAO {
	// 로그인체크
	public UserVO login(String id) {
		UserVO vo = new UserVO();
		try {
			String sql = "select * from user where u_id=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				vo.setU_id(rs.getString("u_id"));
				vo.setPass(rs.getString("pass"));
				vo.setU_name(rs.getString("u_name"));
				vo.setAddress(rs.getString("address"));
				vo.setTel(rs.getString("tel"));
				vo.setPoint(rs.getInt("point"));
				vo.setImage(rs.getString("image"));
				vo.setEmail(rs.getString("email"));
				vo.setDel_user(rs.getInt("del_user"));
			}
		} catch (Exception e) {
			System.out.println("로그인체크" + e.toString());
		}
		return vo;
	}
	
	//회원정보읽기
	public JSONObject read(String u_id) {
	      JSONObject obj = new JSONObject();
		   try {
			   String sql = "select * from user where u_id=?";
			   PreparedStatement ps = Database.CON.prepareStatement(sql);
			   ps.setString(1,u_id);
			   ResultSet rs = ps.executeQuery();
			   if(rs.next()) {
				   obj.put("u_id",rs.getString("u_id"));
				   obj.put("u_name",rs.getString("u_name"));
				   obj.put("pass",rs.getString("pass"));
				   obj.put("address",rs.getString("address"));
				   obj.put("tel",rs.getString("tel"));
				   obj.put("point",rs.getInt("point"));
				   obj.put("image",rs.getString("image"));
			   }
		   }catch(Exception e) {
			   System.out.println("마이페이지: " + e.toString());
		   }
		   return obj;
	   }
	
	//회원정보 수정
	   public void update(UserVO vo)  {
		      try {
		         String sql="update user set pass=?,u_name=?,address=?,tel=?,email=?,image=? where u_id=?";
		         PreparedStatement ps=Database.CON.prepareStatement(sql);
		         ps.setString(1, vo.getPass());
		         ps.setString(2, vo.getU_name());
		         ps.setString(3, vo.getAddress());
		         ps.setString(4, vo.getTel());
		         ps.setString(5, vo.getEmail());
		         ps.setString(6, vo.getImage());
		         ps.setString(7, vo.getU_id());
		         ps.execute();
		      }catch(Exception e) {
		         System.out.println("회원수정 : "+e.toString());
		      }
		   
		   }
	   
	   //회원 탈퇴
	   public void delete(String u_id)  {
		      try {
		         String sql="update user set del_user=1 where u_id=?";
		         PreparedStatement ps=Database.CON.prepareStatement(sql);
		         ps.setString(1, u_id);
		         ps.execute();
		      }catch(Exception e) {
		         System.out.println("회원탈퇴 : " + e.toString());
		      }
		   
		   }
	   
	 //회원가입
	   public int insert(UserVO vo) {
	         int count=-1;
	      try {
	         String sql="call add_user(?,?,?,?,?,?,?)";
	         CallableStatement cs = Database.CON.prepareCall(sql);
	         cs.setString(1, vo.getU_id());
	         cs.setString(2, vo.getPass());
	         cs.setString(3, vo.getU_name());
	         cs.setString(4, vo.getAddress());
	         cs.setString(5, vo.getTel());
	         cs.setString(6, vo.getEmail());
	         cs.registerOutParameter(7, java.sql.Types.INTEGER);
	         cs.execute();
	         count=cs.getInt(7);
	         
	      }catch(Exception e) {
	         System.out.println("회원가입 : "+e.toString());
	      }
	      return count;

	   }

	   
}
