<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>MARKET HONG</title>
   <link rel="stylesheet" href="../style.css"/>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
</head>
<body>
   <div id="header"><jsp:include page="../header.jsp" /></div>
   <div id="menu"><jsp:include page="../menu.jsp" /></div>
   <div id="content">
      <!-- 여기부터 출력할 내용 입력 시작 ------------------------------------>
      <br>
      <div id="shopArea">
         <div id="category">
            <div class="accordion">
               <input type="checkbox" id="tag01"> <label for="tag01">Category</label>
               <div>
                  <button id="allList">All</button>
                  <br>
                  <button id="UList">♡특별상품♡</button>
                  <br>
                  <button id="IList">냉동식품</button>
                  <br>
                  <button id="FList">과일</button>
                  <br>
                  <button id="DList">음료</button>
                  <br>
                  <button id="SList">간식</button>
               </div>
               <input type="checkbox" id="tag02"> <label for="tag02">MyPage</label>
               <div class="page">
                  <button id="userRead">내 정보</button>
                  <br>
                  <button id="cart">장바구니</button>
                  <br>
                  <button id="Plist">내 주문 목록</button>
               </div>
            </div>
         </div>
         <div id="list">
            <!--       목록 출력 시작 -->
                        <table id="tab">
               <tr>
                  <td rowspan=7 id="tdImg" width=400>
                  <c:if test="${pvo.image==null}"><img src="http://placehold.it/400x500" id="image"/></c:if>
                  <c:if test="${pvo.image!=null}"><img src="/img/product/${pvo.image}" id="image" width=400 height=500/></c:if>
                  </td>
                  <td colspan=2 id="tdNameDetail">
                     <input type="text" name="p_name" size=200 value="${pvo.p_name}"><br>
                     <textarea rows="1" cols="50" name="detail">${pvo.detail}</textarea>
                  </td>
               </tr>
               <tr>
                  <td colspan=2 id="tdPrice">
                     &nbsp;상품 금액<input type="text" name="price" size=10 value="${pvo.price}">원<br>
                  </td>
               </tr>
               <tr>
                  <td id="tdNone"></td>
               </tr>
               <tr>
                  <td width=150 id="tdCompany1">&nbsp;제조원</td>
                  <td id="tdCompany"><input type="text" name="company" size=27 value="${pvo.company}" ></td>
               </tr>
               <tr>
                  <td id="tdQuantity">&nbsp;구매수량</td>
                  <td id="tdQuantity">
                     <button id="btnM">-</button>
                  <input type="text" size=10 value=1 id="quantityyy">
                     <button id="btnP">+</button>
                  </td>
               </tr>
               <tr>
                  <td><input type="hidden" name="p_id" size=10 value="${pvo.p_id}" readonly></td>
                  <td id="tdTot">
               총 상품 금액&nbsp;<input type="text" id="totSum" readonly>&nbsp;원&nbsp;<br>
                  </td>
               </tr>
               <tr>
                  <td id="tdBtnInsert1"></td>
                  <td id="tdBtnInsert"><button>장바구니 담기</button></td>
               </tr>
            </table>
            <div id="proreadbutton">
               <button id="proreadbtn">상품설명</button>
            </div>
            <div id="proImg">
               <c:if test="${pvo.image1==null}"><img src="http://placehold.it/400x500" id="image1"/></c:if>
               <c:if test="${pvo.image1!=null}"><img src="/img/product/${pvo.image1}" id="image1" /></c:if>
            </div>
            <!--       목록 출력 종료 -->
         </div>
      </div>
      </div>
      <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   <div id="footer"><jsp:include page="../footer.jsp" /></div>
</body>
<script>
	var price = "${pvo.price}";
	var quantity=1;
	var u_id="${u_id}";
	
	sum();
	
	$("#btnP").on("click", function(){
	   quantity=quantity+1;
	   $("#quantityyy").val(quantity);
	   $("#totSum").val(price*quantity);
	   sum();
	});
	
	$("#btnM").on("click",function(){
	   if(quantity>1){
	      quantity=quantity-1;
	      $("#quantityyy").val(quantity);
	      $("#totSum").val(price*quantity);
	      sum();
	   }else{
	      alert("최소수량입니다.");
	   }
	});
	
	var quantityyy = $("#tab .row #tdQuantity #quantityyy").val();
	
	function sum(){
	   $("#totSum").val(price*quantity);
	}

	 function login(){
	      window.open("/semi/user/wlogin.jsp","","width=500, height=600, top=200, left=900");
	  	 };
  
   $("#userRead").on("click", function(){
      $.ajax({
         type:"get",
         url:"/semi/user/read",
         data:{"u_id":u_id},
         success:function(){
        	 if(u_id==""){
                 alert("로그인을 해주세요!");
                login();
              }else{
             location.href="/semi/user/mypage.jsp";
              }
         }
      });
   });
   $("#tab").on("click","#tdBtnInsert", function(){
	   p_id="${pvo.p_id}";
	   var p_name="${pvo.p_name}";
	   quantity=$("#quantityyy").val();
	    if(!confirm(p_name + "(를)을 장바구니에 담으시겠습니까?")) return;
	    
	    if(u_id==""){
	       alert("로그인을 해주세요!");
	       login();
	    }else{
	       $.ajax({
	          type:"get",
	          url:"/semi/prod/insert",
	          data:{"p_id":p_id,"u_id":u_id,"quantity":quantity},
	          success:function(){
	             alert("장바구니에 " + p_name + " 상품을 담았습니다!");
	             if(!confirm("장바구니로 이동하시겠습니까?")) return;
	             location.href="/semi/cart.jsp";
	          }
	       });
	    }
	 });
   
   
   $("#allList").on("click", function(){
      location.href="/semi/shop/shop.jsp";
      var url="/semi/prod/list";
      page=1;
      getList();
   });
   
   $("#UList").on("click", function(){
      location.href="/semi/shop/shopu.jsp";
      var url="/semi/prod/UList";
      page=1;
      getList();
   });
   
   $("#FList").on("click", function(){
      location.href="/semi/shop/shopf.jsp";
      var url="/semi/prod/FList";
      page=1;
      getList();
   });
   
   $("#SList").on("click", function(){
      location.href="/semi/shop/shops.jsp";
      var url="/semi/prod/SList";
      page=1;
      getList();
   });
   
   $("#IList").on("click", function(){
      location.href="/semi/shop/shopi.jsp";
      var url="/semi/prod/IList";
      page=1;
      getList();
   });
   
   $("#DList").on("click", function(){
      location.href="/semi/shop/shopd.jsp";
      var url="/semi/prod/DList";
      page=1;
      getList();
   });
   
	   $("#Plist").on("click", function(){
    		 if(u_id==""){
               alert("로그인을 해주세요!");
               login();
            }else{
   	      location.href="/semi/user/list.jsp";
            }
   	   });
	   
	  
	   
	   $("#cart").on("click", function(){
  		 if(u_id==""){
             alert("로그인을 해주세요!");
             login();
          }else{
 	      		location.href="/semi/cart.jsp";
          }
 	   });
   
</script>
<script src="/semi/script.js"></script>
</html>