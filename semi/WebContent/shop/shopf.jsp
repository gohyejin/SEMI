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
.image {
	display: block;
	overflow: hidden;
	width: 300px;
	height: 300px;
	cursor: pointer;
}

.image>img {
	width: 100%;
	transition: transform 1.5s;
}

.image:hover>img {
	transform: translate(0%, 0%) scale(1.1);
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
				<h2>PRODUCT LIST</h2>
				<!--       목록 출력 시작 -->
				<div id="divPage">
					<div id="divCondition">
						<div id="divSearch">
							<select id="selKey">
								<option value="p_name">상품명</option>
								<option value="price">가격</option>
								<option value="company">제조사</option>
							</select> <select id="selPerPage">
								<option value="6" selected>6행</option>
								<option value="9">9행</option>
								<option value="12">12행</option>
							</select> <input type="text" id="txtWord"> <input type="button"
								id="btnSearch" value="SEARCH"> <span
								style="font-size: 12px;">count:<b id="count"></b>
							</span>
						</div>
						<div id="divSort">
							<select id="selOrder">
								<option value="p_name">상품명</option>
								<option value="price">가격</option>
								<option value="company">제조사</option>
							</select> <select id="selDesc">
								<option value="">오름차순</option>
								<option value="desc">내림차순</option>
							</select>
						</div>
					</div>

				</div>

				<div id="tbl"></div>
				<script id="temp" type="text/x-handlebars-template">
         {{#each ProdFList}}
            <div class="box">
            <input type="hidden" class="p_id" value="{{p_id}}">
               <div class="image"><img src="/img/product/{{image}}" width=300 height=300/></div>
               <div class="p_name">{{p_name}}</div>
               <div class="company">{{company}}</div>
               <div class="price">{{price}}</div>
               <div><button class="btnCart">장바구니에 담기</button></div>
            </div>
            {{/each}}
            </script>

				<div id="pagination">
					<button id="btnPre">◀</button>
					[ <span id="curPage"></span> / <span id="totPage"></span> ]
					<button id="btnNext">▶</button>
				</div>

			</div>
			<!--       목록 출력 종료 -->
		</div>
	</div>
	<!-- 여기부터 출력할 내용 입력 종료 ------------------------------------>
	<div id="footer"><jsp:include page="../footer.jsp" /></div>
</body>
<script>
	var url = "/semi/prod/FList";
	;

	var u_id = "${u_id}";

	function login() {
		window.open("/semi/user/wlogin.jsp", "",
				"width=500, height=600, top=200, left=900");
	};

	$("#tbl").on("click", ".btnCart", function() {
		var tbl = $(this).parent().parent();
		var p_id = tbl.find(".p_id").val();
		var p_name = tbl.find(".p_name").html();
		if (!confirm(p_name + "(를)을 장바구니에 담으시겠습니까?"))
			return;

		if (u_id == "") {
			alert("로그인을 해주세요!");
			login();
		} else {
			$.ajax({
				type : "post",
				url : "/semi/cart/insert",
				data : {
					"p_id" : p_id,
					"u_id" : u_id
				},
				success : function() {
					alert("장바구니에 " + p_name + " 상품을 담았습니다!");
					if (!confirm("장바구니로 이동하시겠습니까?"))
						return;
					location.href = "/semi/cart.jsp";
				}
			});
		}
	});

	$(".page").on("click", "#cart", function() {
		if (u_id == "") {
			alert("로그인을 해주세요!");
			login();
		} else {
			location.href = "/semi/cart.jsp";
		}
	});

	$(".page").on("click", "#userRead", function() {
		$.ajax({
			type : "get",
			url : "/semi/user/read",
			data : {
				"u_id" : u_id
			},
			success : function() {
				if (u_id == "") {
					alert("로그인을 해주세요!");
					login();
				} else {
					location.href = "/semi/user/mypage.jsp";
				}
			}
		});
	});

	$("#tbl").on("click", ".box .image", function() {
		var row = $(this).parent();
		var p_id = row.find(".p_id").val();
		$.ajax({
			type : "get",
			url : "/semi/prod/read",
			data : {
				"p_id" : p_id
			},
			success : function() {
				location.href = "/semi/prod/read?p_id=" + p_id;
			}
		});
	});

	$("#allList").on("click", function() {
		location.href = "/semi/shop/shop.jsp";
	});

	$("#UList").on("click", function() {
		location.href = "/semi/shop/shopu.jsp";
	});

	$("#FList").on("click", function() {
		location.href = "/semi/shop/shopf.jsp";
	});

	$("#SList").on("click", function() {
		location.href = "/semi/shop/shops.jsp";
	});

	$("#IList").on("click", function() {
		location.href = "/semi/shop/shopi.jsp";
	});

	$("#DList").on("click", function() {
		location.href = "/semi/shop/shopd.jsp";
	});

	$("#Plist").on("click", function() {
		location.href = "/semi/user/list.jsp";
	});

	$("#Plist").on("click", function() {
		if (u_id == "") {
			alert("로그인을 해주세요!");
			login();
		} else {
			location.href = "/semi/user/list.jsp";
		}
	});

	$("#cart").on("click", function() {
		if (u_id == "") {
			alert("로그인을 해주세요!");
			login();
		} else {
			location.href = "/semi/cart.jsp";
		}
	});
</script>
<script src="/semi/script.js"></script>
</html>