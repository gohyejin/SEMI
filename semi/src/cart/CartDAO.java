package cart;

import java.sql.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.*;

public class CartDAO {

    //장바구니출력
    public JSONObject list(SqlVO vo, String u_id) {
       JSONObject jObject = new JSONObject();
       try {
          String sql = "{call cart_list(?,?,?,?,?,?,?)}";
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
          int totSum=0;
          JSONArray jArray = new JSONArray();
          while (rs.next()) {
             JSONObject obj = new JSONObject();
             obj.put("u_id", rs.getString("u_id"));
             obj.put("p_id", rs.getString("p_id"));
             obj.put("p_name", rs.getString("p_name"));
             obj.put("price", rs.getInt("price"));
             obj.put("detail", rs.getString("detail"));
             obj.put("quantity", rs.getInt("quantity"));
             obj.put("image", rs.getString("image"));
             obj.put("sum", (rs.getInt("quantity")*rs.getInt("price")));
             totSum=totSum+(rs.getInt("quantity")*rs.getInt("price"));
             jArray.add(obj);
          }
          
          jObject.put("cartList", jArray);
          cs.getMoreResults();

          rs = cs.getResultSet();

          int count = 0;
          if (rs.next()) {
             count = rs.getInt("total");
          }
          jObject.put("totSum",totSum);
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
    //장바구니에 담기
    public void insert(CartVO vo) {
       try {
          String sql="{call add_cart(?,?,?)}";
          CallableStatement cs=Database.CON.prepareCall(sql);
          cs.setString(1, vo.getU_id());
          cs.setString(2, vo.getP_id());
          cs.setString(3, vo.getImage());
          cs.execute();
       }catch(Exception e) {
          System.out.println("장바구니 등록"+e.toString());
       }
    }
    //장바구니 삭제
    public void delete(String u_id, String p_id) {
       try {
          String sql="delete from cart where u_id=? and p_id=?";
          PreparedStatement ps=Database.CON.prepareStatement(sql);
          ps.setString(1, u_id);
          ps.setString(2, p_id);
          ps.execute();
       }catch(Exception e) {
          System.out.println("장바구니 삭제"+e.toString());
       }
    }
    //장바구니 수량수정
    public void update(String u_id, String p_id) {
       try {
          String sql="update cart set quantity=quantity+1 where u_id=? and p_id=?";
          PreparedStatement ps=Database.CON.prepareStatement(sql);
          ps.setString(1, u_id);
          ps.setString(2, p_id);
          ps.execute();
       }catch(Exception e) {
          System.out.println("장바구니 수정"+e.toString());
       }
    }
    
    //장바구니 수량수정
    public void update1(String u_id, String p_id) {
       try {
          String sql="update cart set quantity=quantity-1 where u_id=? and p_id=?";
          PreparedStatement ps=Database.CON.prepareStatement(sql);
          ps.setString(1, u_id);
          ps.setString(2, p_id);
          ps.execute();
       }catch(Exception e) {
          System.out.println("장바구니 수정"+e.toString());
       }
    }
}