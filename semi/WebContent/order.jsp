<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MARKET HONG</title>
<link rel="stylesheet" href="/semi/style.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript"></script>
</head>
<body>
   <div id="header"><jsp:include page="header.jsp" /></div>
   <div id="menu"><jsp:include page="menu.jsp" /></div>
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
                  <button onClick="location.href='cart.jsp'">장바구니</button>
                  <br>
                  <button>내 주문 목록</button>
               </div>
            </div>
         </div>
         <div id="list">
            <h2>Order</h2><p>주문하실 상품명 및 수량을 정확하게 확인해 주세요.</p>
            <!--       목록 출력 시작 -->
               <div id="orderPage">
             <table id="tbl" border=1>
                <tr class="title">
                  <td width=30></td>
                  <td width=170>상품명</td>
                  <td width=500>상품정보</td>
                  <td width=100>수량</td>
                  <td width=130>상품금액</td>
                  <td width=50></td>
                </tr>
                <tr class="row">
                   <td></td>
                   <td></td>
                   <td></td>
                   <td></td>
                   <td></td>
                   <td></td>
                </tr>
                <tr class=title2>
                   <td colspan=4>총 금액</td>
                   <td class="totSum"></td>
                   <td></td>
                </tr>
             </table>
               </div>
               <h2>User Information</h2>
               <div id="userPage">
               <table id="usertbl">
               <tr>
                  <td width=200 class=title>보내는분</td>
                  <td width=400><input type="text" placeholder=보내는분></td>
               </tr>
               <tr>
                  <td class=title>주소</td>
                  <td><input type=text placeholder=주소></td>
               </tr>
               <tr>
                  <td class=title>번호</td>
                  <td><input type="text" placeholder=번호></td>
               </tr>
               <tr>
                  <td class=title>결제</td>
                  <td>
                     <input type="radio" name="PayType" checked> 카드
                     <input type="radio" name="PayType"> 무통장
                  </td>
               </tr>
               </table>
               </div>
               <br>
               <div id="divOr">
                  <button>주문하기</button>
               </div>
            <!--       목록 출력 종료 -->
         </div>
      </div>   
   </div>
   <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   <div id="footer"><jsp:include page="footer.jsp" /></div>
</body>
<script>
</script>
</html>