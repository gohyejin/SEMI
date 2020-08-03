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
               <div>
                  <button id="userRead">내 정보</button>
                  <br>
                  <button>장바구니</button>
                  <br>
                  <button>내 구매 목록</button>
               </div>
            </div>
         </div>
         <div id="list">
            <!--       목록 출력 시작 -->
            <form name="frm" action="update" method="post" enctype="multipart/form-data">
            <table id="tab">
               <tr>
                  <td rowspan=7 id="tdImg" width=400>
                  <c:if test="${pvo.image==null}"><img src="http://placehold.it/400x500" id="image"/></c:if>
                  <c:if test="${pvo.image!=null}"><img src="/img/product/${pvo.image}" id="image" width=400 height=500/></c:if>
                  <input type="file" name="image" accept="image/*" style="visibility:hidden;">
                  </td>
                  <td colspan=2 id="tdNameDetail">
                     <input type="text" name="p_name" size=99 value="${pvo.p_name}"><br>
                     <textarea rows="1" cols="50" name="detail">${pvo.detail}</textarea>
                  </td>
               </tr>
               <tr>
                  <td colspan=2 id="tdPrice">
                     &nbsp;상품 금액<input type="text" name="price" size=10 value="${pvo.price}">원<br>
                     &nbsp;적립머시기
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
                  <td id="tdQuantity1">&nbsp;구매수량</td>
                  <td id="tdQuantity">
                     <button id="btnM">-</button>
                     <input type="text" size=10 value=0>
                     <button id="btnP">+</button>
                  </td>
               </tr>
               <tr>
                  <td><input type="hidden" name="p_id" size=10 value="${pvo.p_id}" readonly></td>
                  <td id="tdTot">
                     총 상품 금액&nbsp;<input type="text" id="totSum" value="" readonly>&nbsp;원&nbsp;<br>
                     적립머시기머시기&nbsp;
                  </td>
               </tr>
               <tr>
                  <td id="tdBtnInsert1"></td>
                  <td id="tdBtnInsert"><button>장바구니 담기</button></td>
               </tr>
            </table>
            <div id="proreadbutton">
               <button id="proreadbtn">상품설명</button>
               <button>상품이미지</button>
               <button>상세정보</button>
               <button>고객후기(412)</button>
               <button>상품문의2</button>
            </div>
            <div id="proImg">
            
            </div>
            <input type="submit" value="저장"> 
            </form>
            <!--       목록 출력 종료 -->
         </div>
      </div>
      </div>
      <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   <div id="footer"><jsp:include page="../footer.jsp" /></div>
</body>
<script>
   $("#userRead").on("click", function(){
      u_id="${u_id}";
      $.ajax({
         type:"get",
         url:"/semi/user/read",
         data:{"u_id":u_id},
         success:function(){
            location.href="/semi/user/read?u_id="+u_id;
         }
      });
   });
   $("#allList").on("click", function(){
      location.href="/semi/shop.jsp";
      var url="/semi/prod/list";
      page=1;
      getList();
   });
   
   $("#UList").on("click", function(){
      location.href="/semi/shop.jsp";
      var url="/semi/prod/UList";
      page=1;
      getList();
   });
   
   $("#FList").on("click", function(){
      location.href="/semi/shop.jsp";
      var url="/semi/prod/FList";
      page=1;
      getList();
   });
   
   $("#SList").on("click", function(){
      location.href="/semi/shop.jsp";
      var url="/semi/prod/SList";
      page=1;
      getList();
   });
   
   $("#IList").on("click", function(){
      location.href="/semi/shop.jsp";
      var url="/semi/prod/IList";
      page=1;
      getList();
   });
   
   $("#DList").on("click", function(){
      location.href="/semi/shop.jsp";
      var url="/semi/prod/DList";
      page=1;
      getList();
   });
   
    //이미지 불러오기
   $("#image").on("click", function() {
      $(frm.image).click();
   });
   
   //이미지 미리보기
   $(frm.image).on("change", function(e) {
      var reader = new FileReader();/*파일읽는 객체 생성*/
      reader.onload = function(e) {
         $("#image").attr("src", e.target.result);
      }
      reader.readAsDataURL(this.files[0]);
   });
   
   //저장버튼을 클릭한 경우
   $(frm).submit(function(e) {
      e.preventDefault();
      if (!confirm("상품을 수정하시겠습니까?")) return;
      frm.submit();
   });
   
</script>
<script src="/semi/script.js"></script>
</html>