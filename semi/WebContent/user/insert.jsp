<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<link rel="stylesheet" href="../style.css">
</head>
<body>
<body>
   <div id="header"><jsp:include page="../header.jsp" /></div>
   <div id="menu"><jsp:include page="../menu.jsp" /></div>
   <div id="content">
      <!-- 여기부터 출력할 내용 입력 시작 ------------------------------------>
      <div id="signupArea">
         <h3>SIGN UP!</h3>
         <div id="signupPage">
         <table id=tbl>
            <tr>
               <td width=150>아이디 *</td>
               <td width=350><input type="text" class="u_id" size=20 placeholder="15자리까지 가능" maxlength=15></td>
               <td width=150 id="btnCheck"><button>중복확인</button></td>
            </tr>
            <tr>
               <td>비밀번호 *</td>
               <td><input type="password" class="pass" size=20 maxlength=8 placeholder="8자리 입력"></td>
               <td id="btnShow"><button>SHOW</button></td>
            </tr>
             <tr>
               <td>비밀번호확인 *</td>
               <td><input type="password" class="passCheck" size=20 maxlength=8 placeholder="8자리 입력"></td>
            </tr>
            <tr>
               <td>이름 *</td>
               <td><input type="text" class="u_name" maxlength=4 size=20></td>
               <td></td>   
            </tr>
            <tr>
               <td>주소 *</td>
               <td><input type="text" class="address" size=30></td>
             
            </tr>
            <tr>
               <td>전화번호</td>
               <td><input type="text" class="tel" size=30 placeholder=" - 를포함하여 입력해주세요" maxlength=13>
               </td>
               <td></td>
            </tr>
            <tr>
               <td>이메일</td>
               <td><input type="text" class="email" size=30></td>
               <td></td>
            </tr>
         </table>
         <input type="button" value="가입하기" id="btnInsert">
         </div>
      </div>
      <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   </div>
   <div id="footer"><jsp:include page="../footer.jsp" /></div>
</body>
</body>
<script>

   var check=null;
   var id=null;
   //mouseOver   
   $("#btnShow").mouseover(function(){
      $("#tbl .pass").prop("type", "text");
   });
   $("#btnShow").mouseout(function(){
      $("#tbl .pass").prop("type", "password");
   });
   
   //회원가입하기
   $("#btnInsert").on("click",function(){
      id=$("#tbl .u_id").val();
      var pass=$("#tbl .pass").val();
      var passCheck=$("#tbl .passCheck").val();
      var name=$("#tbl .u_name").val();
      var address=$("#tbl .address").val();
      var tel=$("#tbl .tel").val();
      var email=$("#tbl .email").val();

      
      if(id==""||pass==""||passCheck==""||name==""||address==""||tel==""||email==""){
         alert("모든값을 입력해주세여");
      }else if(id==check){
         if(pass==passCheck){
            $.ajax({
               type:"post",
               url:"insert",
               data:{"u_id":id, "pass":pass, "u_name":name, "address":address, "tel":tel, "email":email},
               dataType:"json",
               success:function(data){
                  alert("회원가입이 완료되었습니다!");
                  location.href="/semi/login.jsp";
               }
            });
         }else{
            alert("비밀번호확인이 잘못되었습니다");
         }   
      }else {
         alert("중복체크된 아이디가 아닙니다");
      }
   
   });
   
   
   
   //아이디중복체크
   $("#btnCheck").on("click",function(){
      id=$("#tbl .u_id").val();
      if(id==""){
         alert("아이디를 입력해주세요!");
      }else{
         $.ajax({
            type:"get",
            url:"check",
            data:{"id":id},
            dataType:"json",
            success:function(data){
               if(data.u_id==null){
                  alert("사용가능한 아이디입니다");
                  check=id;
               }else{
                  alert("이미사용중인 아이디입니다");
                  $("#tbl .u_id").val("");
               }
            }
         });
      }
   });
   

</script>
</html>