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
<style>
#otbl .price {text-align:center;}
</style>
</head>
<body>
   <div id="header"><jsp:include page="header.jsp" /></div>
   <div id="menu"><jsp:include page="menu.jsp" /></div>
   <div id="content">
      <!-- 여기부터 출력할 내용 입력 시작 ------------------------------------>
	<div id="pmenu"><jsp:include page="p.jsp"/></div>
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
<div id="cartList">
            <h2>CART</h2>
            <p>주문하실 상품명 및 수량을 정확하게 확인해 주세요.</p>
            <!--       목록 출력 시작 -->
            <div id="cartPage">
               
                  <table id="ctbl"></table>
                  <script id="ctemp" type="text/x-handlebars-template">
                          <tr class="title">
                                <td width=30><input type="checkbox" id="chkAll"></td>
                               <td width=170 id="txtAll">전체선택</td>
                              <td colspan=3 width=500>상품정보</td>
                               <td width=100>수량</td>
                             <td width=130>상품금액</td>
                               <td width=50></td>
                         </tr>
                       {{#each cartList}}
                           <tr class="row">
                             <td class="checkBox"><input type="checkbox" class="chk"></td>
                               <td class="image"><img src="/img/product/{{image}}" width=100 height=100/></td>
                             <td class="p_name1">{{p_name}}</td>
                              <td class="price">{{price}}</td>
                             <td><input type="hidden" value="{{p_id}}" class="p_id1"></td>
                              <td>
                                   <button class="btnM">-</button>
                                   <input type="text" value="{{quantity}}" class="quantity" readonly>
                                 <button class="btnP">+</button>
                              </td>
                             <td class="sum">{{sum}}</td>
                
                              <td><button class="btnDel">X</button></td>
                         <td><input type="hidden" value="{{detail}}" class="detail"></td>
                          </tr>
                       {{/each}}
                       </script>

               <button id="btnDelAll">선택삭제</button>
            </div>
            <div id="divFinal">
               <div id="divSum">
                  <div>
                     <h5>상품금액</h5>
                     <input type="text" id="totSum" readonly> 원
                  </div>
               </div>
               <div id="divOper">
                  <div>+</div>
               </div>
               <div id="divShipping">
                  <div>
                     <h5>배송비</h5>
                     <input type="text" value="3000" readonly> 원
                  </div>
               </div>
               <div id="divOper">
                  <div>=</div>
               </div>
               <div id="divtotSum">
                  <div>
                     <h5>결제예정금액</h5>
                     <input type="text" id="ttotSum" readonly> 원 <br>

                  </div>
               </div>
            </div>
            <br>
            <div class="OrderArea">
               <button id="btnOrder">주문하기</button>
            </div>

            <!--       목록 출력 종료 -->
         </div>
         

         <div id="orderList">
            <h2>Order</h2>
            <p>주문하실 상품명 및 수량을 정확하게 확인해 주세요.</p>
            <!--       목록 출력 시작 -->
            <div id="orderPage">
               <table id="otbl" style="text-align:center"></table>
               <script id="otemp" type="text/x-handlebars-template">
                  <tr class="title">
                     <td width=150>상품명</td>
                     <td width=500>상품정보</td>
                     <td width=80>수량</td>
                     <td width=100>상품금액</td>
					 <td width=100>합계</td>
                  </tr>
                  {{#each .}}
                  <tr class="row">
                     <td>{{name}}<input type="hidden" value={{id}} class="p_id"></td>
                     <td class="detail">{{detail}}</td>
                     <td class="quantity">{{quantity}}</td>
                     <td class="price">{{price}}</td>
					 <td class="sum">{{sum}}</td>
                  </tr>
                  {{/each}}
                  <tr class=title2>
                     <td colspan=4>총 금액</td>
                     <td id="totSum1"></td>
                  </tr>               
               </script>
            </div>
            <h2>User Information</h2>
            <div id="userPage">
               <table id="usertbl">
                  <tr>
                     <td width=200 class=title>받는분</td>
                     <td width=400><input type="text" placeholder=받는분 class="name"></td>
                  </tr>
                  <tr>
                     <td class=title>주소</td>
                     <td><input type=text placeholder=주소 class="address"></td>
                  </tr>
                  <tr>
                     <td class=title>번호</td>
                     <td><input type="text" placeholder=번호 class="tel"></td>
                  </tr>
                  <tr>
                     <td class=title>결제</td>
                     <td><input type="radio" name="payType" checked value="1"> 카드 <input
                        type="radio" name="payType" value="0" > 무통장</td>
                  </tr>
               </table>
            </div>
            <br>
            <div class="OrderArea">
               <button id="divOr">주문하기</button>
            </div>
            <!--       목록 출력 종료 -->
         </div>
      </div>
   </div>
                        
                    
   <!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
   <div id="footer"><jsp:include page="footer.jsp" /></div>
</body>
<script>
var key, word, order, desc, perPage, page = 1;
var u_id="${u_id}";
getList();
var o_id;
var totSum = 0;

$("#orderList").hide();


//주문하기
$("#divOr").on("click",function(){
  if (!confirm("충동구매아님?확실함?"))return;
  var name = $("#usertbl .name").val();
  var address = $("#usertbl .address").val();
  var tel = $("#usertbl .tel").val();
  var payType = $('input[name="payType"]:checked').val();
  if(name==""||address==""||tel==""){
     alert("다입력해주세여");
  }else{
     $("#otbl .row").each(function(){
        var p_id=$(this).find(".p_id").val();
        var price=$(this).find(".price").html();
        var quantity=$(this).find(".quantity").html();
        $.ajax({
           type:"get",
           url:"/semi/purchase/id",
           dataType:"json",
           success:function(data){
              o_id=data.o_id;
              $.ajax({
                 type:"post",
                 url:"/semi/purchase/insert",
                 data:{"o_id":o_id,"u_id":u_id,"p_name":name,"address":address,"tel":tel,"payType":payType,"p_id":p_id,"price":price,"quantity":quantity},
                 dataType:"json",
                 success:function(data){
                    if(data.count==1){
                       alert("주문완료");
                    }else{
                       alert("수량초과한 품목이있습니다!");
                    }
                 }
              });
           }
        });
     });
  }
  location.href="/semi/user/list.jsp";
});


//선택상품눌렀을때
$("#btnOrder").on("click", function() {
   if ($("#ctbl .row .chk:checked").length > 0) {
      $("#cartList").hide();
      $("#orderList").show();
      var totSum=0;
      var array = []; //배열선언
      
      $("#ctbl .row .chk:checked").each(function() {
         var row = $(this).parent().parent();
         id = row.find(".p_id1").val();
         name = row.find(".p_name1").html();
         price = row.find(".price").html();
         quantity = row.find(".quantity").val();
         detail = row.find(".detail").val();
         var sum = row.find(".sum").html();
         totSum = parseInt(totSum) + parseInt(sum);
         data = {
            "id" : id,
            "name" : name,
            "price" : price,
            "quantity" : quantity,
            "detail" : detail,
            "sum" : sum
         };
         array.push(data); //배열에 넣어주기
      });
      var template = Handlebars.compile($("#otemp").html());
      $("#otbl").html(template(array));
      $("#totSum1").html(totSum);
      $('body,html').animate({
          scrollTop : 300
       }, 500);
   } else {
      alert("선택해주세여");
   }
});

function login(){
    window.open("/semi/user/wlogin.jsp","","width=500, height=600, top=200, left=900");
    };

$("#ctbl").on("click", ".row .btnP", function(){
    var p_id=$(this).parent().parent().find(".p_id1").val();
     $.ajax({
        type:"post",
        url:"/semi/cart/update",
        data:{"u_id":u_id, "p_id":p_id},
        success:function(){
        }
     });
     getList();
  });

$("#ctbl").on("click", ".row .btnM", function(){
   var quantity=$(this).parent().parent().find(".quantity").val();
    var p_id=$(this).parent().parent().find(".p_id1").val();
    if(quantity<=1){
       alert("최소수량입니다.");
    }else{
        $.ajax({
           type:"get",
           url:"/semi/cart/update",
           data:{"u_id":u_id, "p_id":p_id},
           success:function(){
           }
        });
        getList();
    }
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


function getList() {
      $.ajax({
         type : "get",
         url : "/semi/cart/list",/* 변수로 입력받아 사용가능 */
         data:{"page":page},
         dataType : "json",
         success : function(data) {
             var template = Handlebars.compile($("#ctemp").html());
             $("#ctbl").html(template(data));
               $("#totSum").val(data.totSum);
               $("#ttotSum").val(data.totSum+3000);
            
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
         }
      });
   }

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
  
  //각 행에있는 체크버튼을 클릭 했을 때
  $("#ctbl").on("click", ".row .chk", function() {
     var isChkAll = true;
     $("#ctbl .row .chk").each(function() {
        if (!$(this).is(":checked")) {
           isChkAll = false;
        }
     });
     if (isChkAll) {
        $("#ctbl #chkAll").prop("checked", true);
     } else {
        $("#ctbl #chkAll").prop("checked", false);
     }
  });

  //전체 체크버튼을 클릭 했을때
  $("#ctbl").on("click", "#chkAll", function() {
     if ($(this).is(":checked")) {
        $("#ctbl .row .chk").each(function() {
           $(this).prop("checked", true);
        });
     } else {
        $("#ctbl .row .chk").each(function() {
           $(this).prop("checked", false);
        });
     }
  });
  
  //삭제 버튼을 클릭 했을 때
  $("#ctbl").on("click", ".row .btnDel", function() {
     var row = $(this).parent().parent();
     var p_id = row.find(".p_id1").val();
     var name = row.find(".p_name1").html();
     if (!confirm(name + "(를)을 장바구니에서 삭제하시겠습니까?"))
        return;
     $.ajax({
        type : "post",
        url : "/semi/cart/delete",
        data : {"p_id":p_id,"u_id":u_id},
        success : function() {
           alert(name + "(를)을 삭제하였습니다!");
           location.href = "cart.jsp";
        }
     });
  });
  
//선택 삭제 버튼을 클릭한 경우
    $("#btnDelAll").on("click", function() {
     if (!confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?")) return;
       $("#ctbl .row .chk:checked").each(function() {
          var row = $(this).parent().parent();
          var p_id = row.find(".p_id1").val();
         var name = row.find(".p_name1").html();
         $.ajax({
             type : "post",
             url : "/semi/cart/delete",
             data : {"p_id":p_id,"u_id":u_id},
             success : function() {
             }
          });
       });

      alert("선택하신 상품을 삭제하였습니다!");
      location.href = "cart.jsp";
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