<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>MARKET HONG</title>
   <link rel="stylesheet" href="../style.css"/>
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
   <!-- 여기부터 출력할 내용 입력 시작 ------------------------------------>
   <div id="loginArea">
      <h3>로그인</h3>
      <input type="text" id="u_id" placeholder=&nbsp;아이디><br>
      <input type="password" id="pass" placeholder=&nbsp;비밀번호 maxlength=8><br>
      <button id="btnLogin">LOGIN</button><br>
      <button id="btnSignup">SIGN UP</button>
   </div>
   <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
</body>
<script>
   $("#pass").keydown(function(key) {
      if (key.keyCode == 13) {
         $("#btnLogin").click();
      }
   });
   
   $("#btnLogin").on("click",function(){
      var u_id = $("#u_id").val();
      var pass = $("#pass").val();
         $.ajax({
            type:"post",
            url:"/semi/user/login",
            data:{"u_id":u_id,"pass":pass},
            dataType:"json",
            success:function(data){
               if(data.check==0){
                  alert("존재하지 않는 아이디입니다!");
               }else if(data.check==1){
                  alert("비밀번호를 확인해 주세요!");
               }else if(data.check==3){
                  alert("탈퇴한 회원입니다.");   
               }
               else{
                  alert("환영합니다!");
                  location.href="/semi/index.jsp";
                  opener.location.href="/semi/index.jsp";
                  window.close();
               }
            }
         });
   });
   
   $("#btnSignup").on("click",function(){
	   opener.location.href="/semi/user/insert.jsp";
	   window.close();
  });
</script>
</html>