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
#divList {
   
}

#divOrder {
   text-align: center;
   border: 1px solid black;
   margin-top: 275px;
   padding-top: 20px;
   padding-bottom: 20px;
}

#UserName {
   text-align: center;
   margin-top: 40px;
   margin-bottom: 40px;
}

#tbl, #jo {
   width: 900px;
}

#tbl {
   display: block;
   text-align: center;
   border-collapse: collapse;
   margin: auto;
   border-bottom: 2px solid #dc1c2c;
}

.title {
   height: 70px;
   border-top: 2px solid #dc1c2c;
   border-bottom: 2px solid #dc1c2c;
   font-size: 18px;
   font-weight: bold;
}

.title1 {
   height: 70px;
   font-size: 18px;
   font-weight: bold;
   background:#EFEFEF;
}

.row {
   height: 60px;
   text-align: center;
   border-bottom: 1px solid gray;
}

.row button {
   width:40px;
   cursor:pointer;
   height:35px;
   background:white;
   border:none;
   outline:none;
}

.row button:hover {
   color:#dc1c2c;
}

.row1 {
   height: 60px;
   text-align: center;
}

#jo {
   border-collapse: collapse;
   text-align: center;
   margin: auto;
   margin-top:30px;
   margin-bottom:50px;
}

.row .address {
   width: 160px;
   height: 20px;
   font-size: 15px;
}

#jo .row td {
   padding: 8px;
}

#jo input[type='text'] {
   outline:none;
   border:none;
}

#jo .p_name {
   width: 100px;
   height: 20px;
   font-size: 15px;
   font-weight:normal;
   text-align:center;
}

#jo .address {
   width: 200px;
   height: 20px;
   font-size: 15px;
   margin-top:3px;
   border-bottom:0.5px solid gray;
}

#jo .tel {
   width: 100px;
   height: 20px;
   font-size: 15px;
   text-align:center;
}

#divRead button {
   width:70px;
   height:25px;
   cursor:pointer;
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
         <!-- ---------------------------------------------------------------------- -->
         <div id="list">
            <h2>Order List</h2>
            <br>
            <hr style="border: solid 5px red;">
            <!--       목록 출력 시작 -->
            <div id="divList">
               <div style="text-align: center; margin-top: 30px;">
                  <div style="position: absolute;">
                     <div id="info">
                        <img src="/semi/img/info.jpg" width=1003px; height=300px;>
                     </div>
                  </div>
                  <div
                     style="margin-left: 450px; margin-top: 100px; position: absolute;">
                     <img
                        src="https://t1.daumcdn.net/cfile/tistory/243FE450575F82662D"
                        style="border-radius: 100%; width: 150px;">
                  </div>
               </div>
               <br>
               <div id="divOrder">
                  <h2 id="UserName">[ ${u_name} ]</h2>
                  <br>
                  <table id="tbl"></table>
                  <script id="temp" type="text/x-handlebars-template">
            <tr class="title">
            <td width=100>주문번호</td>
            <td width=345>상품명</td>
            <td width=100>수량</td>
            <td width=100>가격</td>
            <td width=150>주문자성명</td>
            <td width=150>주문자정보</td>
         </tr>
         {{#each PurList}}
         <tr class="row">
            <td class="o_id" p_id={{p_id}}>{{o_id}}</td>
         	<td>{{prname}}</td>
           <td>{{quantity}}</td>
         	<td>{{price}}</td>
            <td>{{puname}}</td>
            <td><button>보기</button></td>
         </tr>
         {{/each}}
      </script>
				<div id="pagination">
					<button id="btnPre">◀</button>
					[ <span id="curPage"></span> / <span id="totPage"></span> ]
					<button id="btnNext">▶</button>
				</div>
                  <br>
                  <table id="jo" border=1></table>
                  <script id="temp1" type="text/x-handlebars-template">
         <tr class="title1">
            <td>주문번호</td>
            <td width=100>이름</td>
            <td>주소</td>
            <td width=100>전화번호</td>
            <td>결제방법</td>
            <td>결제상태</td>
         </tr>
      
         <tr class="row1">
            <td width=100 class="o_id">{{o_id}}</td>
            <td><input type="text" class="p_name" value={{p_name}}></td>
            <td><input type="text" class="address" value={{address}}></td>
            <td><input type="text" class="tel" value={{tel}}></td>
            <td>
               <input name=payType type="radio" value="0" {{chkPay0 payType}}> 무통장
               <input name=payType type="radio" value="1" {{chkPay1 payType}}> 카드            
            </td>
            <td>{{chkSta0 status}}</td>
         </tr>
      </script>
      <div id="divRead">
                  <button id="btnUpdate">수정</button>
                  <button id="btnDelete">주문취소</button>
               </div>
               </div>


               
            </div>
            <!-- divList -->


         </div>
      </div>
   </div>
   <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   <div id="footer"><jsp:include page="../footer.jsp" /></div>
</body>
<script>
   getList();
   var key, word, order, desc, perPage, page = 1;
   var p_id;
   var u_id= "${u_id}";
  
   function login(){
	      window.open("/semi/user/wlogin.jsp","","width=500, height=600, top=200, left=900");
	  	 };
   
	  	//주문취소하기
	     $("#btnDelete").on("click",function(){
	        if(confirm("취소하시겠습니까?")==false)return;
	        
	        var o_id = $("#jo .row1 .o_id").html();
	        
	        $.ajax({
	           type:"post",
	           url:"/semi/order/delete",
	           data:{"o_id":o_id, "p_id":p_id},
	           dataType:"json",
	           success:function(data){
	              if(data.count==1){
	                 alert("취소되었습니다");
	                 location.href="list.jsp";
	              }else{
	                 alert("결제완료된 상품은 취소 할 수 없습니다");
	                 
	              }
	           }
	        });
	     });
	  	
 //다음 버튼을 클릭했을때
   $("#btnNext").click(function() {
      page++;
      getList();
   });

   //이전 버튼을 클릭했을 때
   $("#btnPre").click(function() {
      page--;
      getList();
   });
   
   function getList() {
      var u_id = $(this).parent().parent().find(".u_id").html();
       $.ajax({
          type : "get",
          url:"/semi/purchase/list",/* 변수로 입력받아 사용가능 */
          data:{"key":key,"word":word,"order":order,"desc":desc,"perPage":perPage,"page":page,"u_id":u_id},
          dataType : "json",
          success : function(data) {
              var template = Handlebars.compile($("#temp").html());
              $("#tbl").html(template(data));  
             
             // page가 1일때 이전버튼 비활성화
             if (data.page == 1) {
                $("#btnPre").attr("disabled", true);
             } else {
                $("#btnPre").attr("disabled", false);
             }
             // page가 전체 페이지 수와 같을때 다음버튼 비활성화
             if (data.page == data.totPage) {
                $("#btnNext").attr("disabled", true);
             } else {
                $("#btnNext").attr("disabled", false);
             }

             $("#curPage").html(data.page);
             $("#totPage").html(data.totPage);
             $("#count").html(data.count);
          }
       });
    }

   $("#divRead").hide();
   $("#jo").hide();
   
   $("#tbl").on("click", ".row button", function() {
      var o_id = $(this).parent().parent().find(".o_id").html();
      p_id = $(this).parent().parent().find(".o_id").attr("p_id");
      var payType = $('input[name="payType"]:checked').val();
      var status = $('input[name="status"]:checked').val();
      
      $.ajax({
         type : "get",
         url : "/semi/purchase/read",
         data : {"o_id" : o_id},
         dataType : "json",
         success : function(data) {
                   
            var temp = Handlebars.compile($("#temp1").html());
            $("#jo").html(temp(data));
            $("#divRead").show();
            $("#jo").show();
         }
      });
   });
   //핸들바 함수(payType)
      Handlebars.registerHelper("chkPay0",function(payType){
      var src;
      if(payType==0){
         src="checked";
      }else{
         src="";
      }
      return src;
   });
   Handlebars.registerHelper("chkPay1",function(payType){
      var src;
      if(payType==1){
         src="checked";
      }else{
         src="";
      }
      return src;
   });
   //핸들바 함수(status)
    Handlebars.registerHelper("chkSta0",function(status){
      var chk;
      if(status==0){
         chk="처리중";
      }else{
         chk="완료";
      }
      return chk;
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
   
   //주문자 수정 
   $("#btnUpdate").on("click", function() {
      var o_id = $("#jo .row1 .o_id").html();
      var p_name = $("#jo .row1 .p_name").val();
      var address = $("#jo .row1 .address").val();
      var tel = $("#jo .row1 .tel").val();
      var payType = $('input[name="payType"]:checked').val();
      var status = $('input[name="status"]:checked').val();
      $.ajax({
         type : "post",
         url : "/semi/purchase/update",
         data : {"o_id" : o_id,"p_name" : p_name,"address" : address,"tel" : tel,"payType" : payType,"status" : status},
         success : function() {
            alert("수정되었습니다");
            location.href = "/semi/user/list.jsp";
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
</html>