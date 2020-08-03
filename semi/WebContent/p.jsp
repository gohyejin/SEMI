<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#floatMenu {
   position: absolute;
   width: 70px;
   height: 165px;
   right: 30px;
   top: 400px;
   background-color: white;
   border:0.5px solid black;
   border-radius:6px 6px 6px 6px;
   padding:10px;
}

#floatMenu div {
   font-size:13px;
   cursor:pointer;
}

h5 {
   margin-top:10px;
   margin-bottom:10px;
   text-align:center;
}

#floatMenu a {
   text-decoration:none;
   color:black;
}

#floatMenu a:hover {
   color:#dc1c2c;
}

#floatMenu hr {
   background-color:#dc1c2c;
}
</style>
</head>
<body>
<div id="floatMenu" style="overflow:hidden;">
   <h5>퀵 메뉴</h5>
   <hr>
   <br>
   <div><a href="/semi/user/mypage.jsp">마이페이지</a></div><br>
   <div><a href="/semi/cart.jsp">장바구니</a></div><br>
   <div><a href="/semi/user/list.jsp">주문목록</a></div>
</div>
</body>
<script>
$(document).ready(function() {

   // 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
   var floatPosition = parseInt($("#floatMenu").css('top'));
   // 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

   $(window).scroll(function() {
      // 현재 스크롤 위치를 가져온다.
      var scrollTop = $(window).scrollTop();
      var newPosition = scrollTop + floatPosition + "px";

      /* 애니메이션 없이 바로 따라감
       $("#floatMenu").css('top', newPosition);
       */

      $("#floatMenu").stop().animate({
         "top" : newPosition
      }, 500);

   }).scroll();

});

$("#floatMenu").stop().animate({
   "top" : newPosition
}, {
   'duration' : 500,
   'easing' : 'easeInOutCubic',
   'complete' : function() {
      console.log('이동 완료하였습니다.');
   }
});

</script>
</html>