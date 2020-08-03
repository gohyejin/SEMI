/mall/list.jsp

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html>
<head>
<title>업체목록</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../home.css" />
</head>
<body>
   <div id="divPage">
      <div id="divMenu"><jsp:include page="../menu.jsp" /></div>
      <div id="divHeader">
         <h2>업 체 목 록</h2>
      </div>
      <div id="divCondition">
         <div id="divSearch">
            <select id="Key">
               <option value="m_id">업체코드</option>
               <option value="m_name">업체명</option>
               <option value="address">주소</option>
            </select> <input type="text" id="word"> <select id="selPerPage">
               <option value="3">3행</option>
               <option value="5">5행</option>
               <option value="10">10행</option>
            </select> <input type="button" id="btnSearch" value="검색"> <span
               style="font-size: 12px;">검색수: <b id="count"></b>건
            </span>
         </div>
         <div id="divSort">
            <select id="order">
               <option value="m_id">업체코드</option>
               <option value="m_name">업체명</option>
               <option value="address">주소</option>
            </select> <select id="desc">
               <option value="">오름차순</option>
               <option value="desc">내림차순</option>
            </select>
         </div>
      </div>
      <table id="tbl"></table>
      <script id="temp" type="text/x-handlebars-template">
            <tr class="title">
               <td>업체코드</td>
               <td>업체명</td>
               <td>관리자</td>
               <td>주소</td>
               <td>전화번호</td>
               <td>이메일</td>
               <td>업체정보</td>
            </tr>
         {{#each mallList}}
            <tr class="row">
               <td class="m_id">{{m_id}}</td>
                   <td>{{m_name}}</td>
                   <td>{{manager}}</td>
                   <td>{{address}}</td>
                   <td>{{tel}}</td>
                   <td>{{email}}</td>
               <td><button>업체정보</button></td>
            </tr>
         {{/each}}
      </script>
      <<div id="pagination">
         <button id="btnPre">◀</button>
         <button id="btnNext">▶</button>
         [<span id="curPage"></span>/<span id="totPage"></span>]
      </div>
      <table id=tbl1></table>
      <script id="temp1" type="text/x-handlebars-template">
            <tr class="title">
               <td>업체코드</td>
               <td>업체명</td>
               <td>관리자</td>
               <td>주소</td>
               <td>전화번호</td>
               <td>이메일</td>
            </tr>
               <tr class="row">
               <td class="m_id">{{m_id}}</td>
                   <td><input type="text" class="m_name" value={{m_name}}></td>
                   <td><input type="text" class="manager" value={{manager}}></td>
                   <td><input type="text" class="address" value={{address}}></td>
                   <td><input type="text" class="tel" value={{tel}}></td>
                   <td><input type="text" class="email" value={{email}}></td>
            </tr>
      </script> 
         <div id="divRead">
            <button id="btnUpdate">수정</button> 
            <button>취소</button>
            <button id="btnDelete">삭제</button>
         </div>
   </div>
</body>
<script>
   url="/semi/mall/list";

   $("#divRead").hide();
   //업체정보
   $("#tbl").on("click",".row button",function(){
      var m_id=$(this).parent().parent().find(".m_id").html();
      $.ajax ({
         type:"get",
         url:"/semi/mall/read",
         data:{"m_id":m_id},
         dataType:"json",
         success:function(data){
            var temp=Handlebars.compile($("#temp1").html());
               $("#tbl1").html(temp(data));   
               $("#divRead").show();
         }
      
      });
      
   });

   //업체 수정 
   $("#btnUpdate").on("click",function(){
      var m_id=$("#tbl1 .row .m_id").html();
      var m_name=$("#tbl1 .row .m_name").val();
      var manager=$("#tbl1 .row .manager").val();
      var tel=$("#tbl1 .row .tel").val();
      var address=$("#tbl1 .row .address").val();
      var email=$("#tbl1 .row .email").val();
      $.ajax ({
         type:"post",
         url:"/semi/mall/update",
         data:{"m_id":m_id,"m_name":m_name,"manager":manager,"tel":tel,"address":address,"email":email},
         success:function(data){
            alert("수정되었습니다");
            location.href="/semi/mall/list.jsp";
         }
      
      });
      
   });
   //업체 삭제
   $("#btnDelete").on("click",function(){
      m_id=$("#tbl1 .row .m_id").html();
      $.ajax ({
         type:"post",
         url:"/semi/mall/delete",
         data:{"m_id":m_id},
         dataType:"json",
         success:function(data){
            if(data.count==0) {
               alert("업체가 삭제되었습니다");
            }else {
               alert("판매상품이 있어 삭제할 수 없습니다");
            }
         }
      
      });
      
   });

   
</script>
<script src="../script.js"></script>
</html>