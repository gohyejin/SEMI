package purchase;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import database.*;
import order.OrderVO;
import product.ProductVO;

public class PurchaseDAO {
   //주문자수정
      public void update(PurchaseVO vo) {
         try {
         String sql="update purchase set p_name=?,address=?,tel=?,payType=?,status=? where o_id=?";
         PreparedStatement ps=Database.CON.prepareStatement(sql);
         ps.setString(1, vo.getP_name());
         ps.setString(2, vo.getAddress());
         ps.setString(3, vo.getTel());
         ps.setString(4, vo.getPayType());
         ps.setString(5, vo.getStatus());
         ps.setString(6, vo.getO_id());
         ps.execute();
         }catch(Exception e) {
         System.out.println("주문자수정:" + e.toString());
         }
         }
   
       //특정 유저의 주문목록 출력
         public JSONObject list(SqlVO vo, String u_id) {
             JSONObject jObject = new JSONObject();
             try {
                String sql="{call order_list(?,?,?,?,?,?,?)}";
                CallableStatement cs=Database.CON.prepareCall(sql);
                
                cs.setString(1, "o_id");
                cs.setString(2, vo.getWord());
                cs.setString(3, vo.getOrder());
                cs.setString(4, "desc");
                cs.setInt(5, vo.getPage());
                cs.setInt(6, vo.getPerPage());
                cs.setString(7, u_id);
                cs.execute();
                ResultSet rs = cs.getResultSet();
                
                JSONArray jArray = new JSONArray();
                while(rs.next()) {
                   JSONObject obj=new JSONObject();
                   obj.put("o_id", rs.getString("o_id"));
                   obj.put("u_id", rs.getString("u_id"));
                   obj.put("p_id", rs.getString("p_id"));
                   obj.put("company", rs.getString("company"));
                   obj.put("price", rs.getInt("price"));
                   obj.put("quantity", rs.getInt("quantity"));
                   obj.put("puname", rs.getString("puname"));
                   obj.put("prname", rs.getString("prname"));
                   obj.put("image", rs.getString("image"));
                   jArray.add(obj);
                }
                jObject.put("PurList",jArray);
                cs.getMoreResults();
                
                rs=cs.getResultSet();
                
                int count=0;
                if(rs.next()) {
                   count=rs.getInt("total");
                }

                jObject.put("count",count);
                jObject.put("perPage",vo.getPerPage());
                jObject.put("page",vo.getPage());
                
                int totPage = count%vo.getPerPage()==0?count/vo.getPerPage()
                                             :count/vo.getPerPage()+1;
                jObject.put("totPage",totPage);
                
             }catch(Exception e) {
                System.out.println("주문자목록 출력" + e.toString());
             }   
             return jObject;
          }
      
 
    //구매정보 읽기
     public PurchaseVO read(String o_id) {
        PurchaseVO vo=new PurchaseVO();
        try {
           String sql="select * from purchase where o_id=?";
           PreparedStatement ps=Database.CON.prepareStatement(sql);
           ps.setString(1, o_id);
           ResultSet rs=ps.executeQuery();
           if(rs.next()) {
              vo.setO_id(rs.getString("o_id"));
              vo.setU_id(rs.getString("u_id"));
              vo.setAddress(rs.getString("address"));
              vo.setTel(rs.getString("tel"));
              
              vo.setPayType(rs.getString("payType"));
              vo.setStatus(rs.getString("status"));
              vo.setP_name(rs.getString("p_name"));
              
              }
        }catch(Exception e) {
           System.out.println("구매정보읽기:"+e.toString());
        }
        return vo;
     }
     
     //새로운 주문번호 얻기
     public String getO_id() {
        String o_id="";
        try {
           String sql="select max(o_id) o_id from purchase";
           PreparedStatement ps=Database.CON.prepareStatement(sql);
           ResultSet rs=ps.executeQuery();
           while(rs.next()) {
              String maxID= rs.getString("o_id").substring(1);
              o_id= "P" + (Integer.parseInt(maxID)+1);
           }
        }catch(Exception e) {
           System.out.println("새로운 주문번호 얻기"+e.toString());
        }
        return o_id;
     }
     
     // 구매자,주문 등록
     public int insert(OrderVO vo) {
        int count=-1;
        try {
           String sql="{call add_purchase_orders(?,?,?,?,?,?,?,?,?,?,?)}";
           CallableStatement cs=Database.CON.prepareCall(sql);
           cs.setString(1, vo.getO_id());
           cs.setString(2, vo.getU_id());
           cs.setString(3, vo.getAddress());
           cs.setString(4, vo.getTel());
           cs.setString(5, vo.getPayType());
           cs.setString(6, "0");
           cs.setString(7, vo.getP_name());
           cs.setString(8, vo.getP_id());
           cs.setInt(9, vo.getPrice());
           cs.setInt(10, vo.getQuantity());
           cs.registerOutParameter(11, java.sql.Types.INTEGER);
           cs.execute();
           
           count=cs.getInt(11);
           
        }catch(Exception e) {
           System.out.println("구매자,주문입력"+e.toString());
        }
        return count;
     }
}