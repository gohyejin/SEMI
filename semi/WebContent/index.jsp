<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MARKET HONG</title>
<link rel="stylesheet" href="style.css" />
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script>
   $(document).ready(function() {
      $('.slider').bxSlider();
   });
</script>
<style>
.bx-wrapper {
   height: 600px;
}

.bx-wrapper .bx-pager.bx-default-pager a, .bx-prev, .bx-next {
   display:none;
}

.prodName {
   text-align: center;
   color: #464646;
   font-size: 40px;
   padding-top: 50px;
   
}

#specialProd a {
   border:1px;
   margin-top:50%;
   text-decoration:none;
   color:white;
   
}

#divA {
   background:#dc1c2c;
   width:80px;
   height:20px;
   text-align:center;
   margin-top:50px;
   margin:auto;
   border-radius: 10px 10px 10px 10px;
   padding:7px;
}

#specialProd li {
   list-style:none;
}

#bestProd {
   width: 100%;
   background: #F7F8F9;
   height: 600px;
   margin-top: 50px;
}

h3 {
   color:#464646;
}

.list_best {
   width: 1750px;
   height: 400px;
   margin: auto;
}

.list {
   width: 1750px;
   height: 400px;
   text-align: center;
   list-style: none;
   padding-left: 80px;
}

.list li {
   float: left;
   margin: auto;
   text-align: center;
   margin: 25px;
   padding-left: 10px;
}

.list img {
   margin-top:20px;
   margin-bottom: 30px;
   text-align: center;
   width: 250px;
   height: 300px;
   cursor: pointer;
   box-shadow: 5px 10px 15px gray;
}

#specialProd {
   width: 100%;
   background: #EBECEE;
   height: 600px;
}

#fruitProd {
   width: 100%;
   background: #F7F8F9;
   height: 600px;
}

#fruitProd img{
   width: 200px;
   height: 300px;
   margin: 25px;
   padding-left:4px;
}
</style>

</head>
<body>
   <div id="header"><jsp:include page="header.jsp" /></div>
   <div id="menu"><jsp:include page="menu.jsp" /></div>
   <div id="content"
      style="width: 1650px; margin: auto; text-align: center;">
      <div class="slider">
         <div>
            <ul class="bxslider" style="">
               <li><img src="./img/ad1.jpg" alt=""></li>
               <li><img src="./img/ad2.jpg" alt=""></li>
               <li><img src="./img/ad3.jpg" alt=""></li>
               <li><img src="./img/ad4.jpg" alt=""></li>
               <li><img src="./img/ad5.jpg" alt=""></li>
            </ul>
         </div>
      </div>
   </div>
   <div id="prodList">
      <div id="bestProd"></div>
      <script id="bestTemp" type="text/x-handlebars-template">
      <div class="prodName">
         마켓홍이 처음인 당신을 위한 <b style="color:#dc1c2c">BEST 추천상품</b>
      </div>
      <div class="list_best">         
           <ul class="list">
            {{#each array}}
                  <li>
                      <img src="/img/product/{{image}}" width=250 height=300/>
                      <h3>{{p_name}}</h3>
                   </li>
                 {{/each}}
             </ul>
                 
      </div>
      </script>
      <div id="specialProd"></div>
      <script id="specialTemp" type="text/x-handlebars-template">
      <div class="prodName">
         마켓홍만의 <b style="color:#dc1c2c;">특별 상품</b>
      </div>

      <div class="list_best">
         <ul class="list">
            {{#each ProdUList}}
               <li>
                  <img src="/img/product/{{image}}" width=200 height=250/>
                  <h3>{{p_name}}</h3>
               </li>   
            {{/each}}   
         </ul>
      <br>
         <li>
         <div id="divA">
            <a href="/semi/shop/shopu.jsp">더보기</a>
         </div>
        </li>
      </div>
      </script>
         
      
      <div id="fruitProd">
         <div class="prodName"><b>카테고리</b></div>
         <div class="list_best">
            <ul class="list">
               <li><a href="/semi/shop/shopf.jsp"><img src="/semi/img/in1.jpg"></a>
               </li>
               <li><a href="/semi/shop/shopi.jsp"><img src="/semi/img/in2.jpg"></a>
               </li>
               <li><a href="/semi/shop/shopd.jsp"><img src="/semi/img/in3.jpg"></a>
               </li>
               <li><a href="/semi/shop/shops.jsp"><img src="/semi/img/in4.jpg"></a>
               </li>
               <li><a href="/semi/shop/shopu.jsp"><img src="/semi/img/in5.jpg"></a>
               </li>
            </ul>
         </div>
      </div>


   </div>
   <div id="footer"><jsp:include page="footer.jsp" /></div>
</body>


<script>
   bestList();
   specialList();
   
   
   //베스트상품목록 출력
   function bestList(){
      $.ajax({
         type:"get",
         url:"/semi/prod/bestList",
         dataType:"json",
         success:function(data){
            var template = Handlebars.compile($("#bestTemp").html());
              $("#bestProd").html(template(data));
         }
      });
   }
   //스페셜상품목록 출력   
   function specialList(){
      $.ajax({
         type:"get",
         url:"/semi/prod/UList",
         dataType:"json",
         success:function(data){
            var template = Handlebars.compile($("#specialTemp").html());
              $("#specialProd").html(template(data));
         }
      });
   }
   
   $(document).ready(function() {

      $('.bxslider').bxSlider({ // 클래스명 주의!

         auto : true, // 자동으로 애니메이션 시작

         speed : 500, // 애니메이션 속도

         pause : 2000, // 애니메이션 유지 시간 (1000은 1초)

         mode : 'horizontal', // 슬라이드 모드 ('fade', 'horizontal', 'vertical' 이 있음)

         captions : true, // 이미지 위에 텍스트를 넣을 수 있음

      });

   });
</script>
</html>