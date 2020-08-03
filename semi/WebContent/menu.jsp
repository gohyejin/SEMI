<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="menuGrid">
   <div id="menuLeft">
      <div class="itemHome"><a href="/semi/index.jsp">HOME</a></div> 
      <div class="itemShop"><a href="/semi/shop/shop.jsp">SHOP</a></div> 
   </div>
   <div id="menuCenter">
      <div class="itemSearch">
         <div></div>
         <input type="text" id="textWord">
         <input type="image" class="wordSearch" src="https://res.kurly.com/pc/service/common/1908/ico_search_x2.png">
      </div>
   </div>
   <div id="menuRight">
   <c:if test="${u_id!=null}">      
      <div class="itemLogin"><a href="/semi/user/logout">LOGOUT</a></div>
   </c:if>
   
   <c:if test="${u_id==null}">
      <div class="itemLogin"><a id="login">LOGIN</a></div>
   </c:if>
      <div class="itemCart"><a id="cart">CART</a></div>
   </div>
</div>

<script>
   var u_id="${u_id}";
   
   $(".itemCart").on("click", "#cart", function(){
      if(u_id==""){
         alert("로그인을 해주세요!");
         window.open("/semi/user/wlogin.jsp","","width=500, height=600, top=200, left=900");
      }else{
         location.href="/semi/cart.jsp";
      }
   });
   
   
	$(".itemSearch").on("click", ".wordSearch", function(){
	   var word = $("#textWord").val();
	   $.ajax({
		      type : "get",
		      url : "/semi/prod/searchList",
		      data : {"word" : word},
		      dataType : "json",
		      success : function() {
		    	  location.href="/semi/shop/shopa.jsp";
		      }
		   });
	});
	
	   //검색창에서 엔터를 클릭했을때
	   $("#textWord").keydown(function(key) {
	      if (key.keyCode == 13) {
	    	  $(".wordSearch").click();
	      }
	   });
	   
	   $("#login").on("click", function(){
		      window.open("/semi/user/wlogin.jsp","","width=500, height=600, top=200, left=900");
		   });
</script>