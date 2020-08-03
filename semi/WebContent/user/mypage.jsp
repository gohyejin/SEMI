<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MARKET HONG</title>
<link rel="stylesheet" href="../style.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript"></script>
<style>
#divList{
   margin-left:150px;
}

#divUser{
   width:700px;
   text-align:center;
   border:1px solid black;
   margin-top:275px;
   padding-top:20px;
   padding-bottom:20px;
}


#UserName {
   text-align:center; 
   margin-top:40px;
   margin-bottom:20px;
}

#tblUser{
   margin:auto;
   width:400px;
   border:none;
}

.title{
   width:150px;
   text-align:left;
}

.row{
   width:300px;
   height:50px;
   text-align:left;
   
}

.row input[type="text"]{
   width:290px; 
   height:25px;
   border:none;
   border-bottom:0.5px solid gray;
   outline:none;
}

input[type='password'] {
   border:none;
   border-bottom:0.5px solid gray;
   outline:none;
}

#show,#hide{
   float: left;
   height: 25px;
   width: 240px;
   padding-bottom:-3px;
}

#showPass,#hidePass{
   float: right;
   height: 25px;
   width: 50px;
}

#pagination {
   margin-top:50px;
}

#pagination input[type='button'] {
   height:25px;
   width:100px;
   margin-right:-8px;
   margin-left:17px;
}

#pagination input[type='reset'] {
   height:25px;
   width:100px;
   margin-right:-8px;
}

</style>
</head>
<body>
   <div id="header"><jsp:include page="../header.jsp" /></div>
   <div id="menu"><jsp:include page="../menu.jsp" /></div>
   <div id="content">
      <!-- 여기부터 출력할 내용 입력 시작 ------------------------------------>
      	<div id="pmenu"><jsp:include page="../p.jsp"/></div>
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
            <h2>My Page</h2>
            <br>
            <hr style="border: solid 5px red;">
            <!--       목록 출력 시작 -->
            <div id="divList">
            <div style=" text-align: center; margin-top: 30px;">
               <div style=" position: absolute; ">
                  <div id="info">
                     <img src="../img/info.jpg" width=703px; height=300px;>
                  </div>
               </div>
               <div style="margin-left:280px; margin-top:100px;position: absolute;">
                  <img src="https://t1.daumcdn.net/cfile/tistory/243FE450575F82662D" style="border-radius: 100%; width:150px;">
                  <p>안녕하세요</p>
               </div>
            </div>
            <br>
            <div id="divUser">
               <h2 id="UserName">[ ${u_name} ]</h2><br>
               <table id="tblUser">
                  <tr>
                     <td class="title"><b>ID</b></td>
                     <td class="row"><input type="text" name="u_id" size=10 value="${u_id}" readonly></td>
                  </tr>
                  <tr>
                     <td class="title"><b>PW</b></td>
                     <td class="row">
                       <input type="password" size=27 id="hide" value="${pass}">
                        <input type="text" size=27 id="show" value="${pass}">
                        <button id="showPass">SHOW</button>
                        <button id="hidePass">HIDE</button>
                     </td>
                  </tr>
                  <tr>
                     <td class="title"><b>E-MAIL</b></td>
                     <td class="row"><input type="text" id="email" size=10 value="${email}"></td>
                  </tr>
                  <tr>
                     <td class="title"><b>ADDRESS</b></td>
                     <td class="row"><input type="text" id="address" size=10 value="${address}"></td>
                  </tr>
                  <tr>
                     <td class="title"><b>TEL</b></td>
                     <td class="row"><input type="text" name="tel" size=10 value="${tel}"></td>
                  </tr>
               </table>
               <div id="pagination">
                  <input type="button" value="수정" id="UserUpdate">
                  <input type="button" value="회원탈퇴" id="delete">
               </div>
            </div>
            </div> <!-- divList -->
         </div>
         <!--       목록 출력 종료 -->
      </div>
   </div>
   <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   <div id="footer"><jsp:include page="../footer.jsp" /></div>
</body>
<script>
   var u_id="${u_id}";
   function login(){
	      window.open("/semi/user/wlogin.jsp","","width=500, height=600, top=200, left=900");
	  	 };
   
   $("#delete").on("click", function(){
   if(!confirm("정말 탈퇴 하시겠습니까?")) return;
      $.ajax({
         type:"post",
         url:"/semi/user/delete",
         data:{"u_id":u_id},
         success:function(){
           alert("탈퇴가 완료되었습니다!");
            location.href="/semi/user/logout";
         }
      });
   });
   
   $("#show").hide();
   $("#hidePass").hide();
   
   $("#showPass").on("click", function(){
      $("#show").show();
      $("#hidePass").show();
      $("#hide").hide();
      $("#showPass").hide();
    });
   
   $("#hidePass").on("click", function(){
      $("#hide").show();
      $("#showPass").show();
      $("#show").hide();
      $("#hidePass").hide();
   });
   
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

   $("#allList").on("click", function(){
	      location.href="/semi/shop/shop.jsp";
	   });

	   $("#UList").on("click", function(){
	      location.href="/semi/shop/shopu.jsp";
	   });

	   $("#FList").on("click", function(){
	      location.href="/semi/shop/shopf.jsp";
	   });

	   $("#SList").on("click", function(){
	      location.href="/semi/shop/shops.jsp";
	   });

	   $("#IList").on("click", function(){
	      location.href="/semi/shop/shopi.jsp";
	   });

	   $("#DList").on("click", function(){
	      location.href="/semi/shop/shopd.jsp";
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
<script src="../home.js"></script>
</html>