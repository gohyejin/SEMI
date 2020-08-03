var key, word, order, desc, perPage, page = 1, url;
getList();
// 검색버튼을 클릭했을 때
$("#btnSearch").on("click", function() {
	page = 1;
	getList();
});

// 각각의 값들이 바뀔때
$("#selOrder, #selDesc, #selPerPage").change(function() {
	page = 1;
	getList();
});

// 검색창에서 엔터를 클릭했을때
$("#txtWord").keydown(function(key) {
	if (key.keyCode == 13) {
		page = 1;
		getList();
	}
});

// 목록 출력
function getList() {
	key = $("#selKey").val();
	word = $("#txtWord").val();
	order = $("#selOrder").val();
	desc = $("#selDesc").val();
	perPage = $("#selPerPage").val();
	$.ajax({
		type : "get",
		url : url,/* 변수로 입력받아 사용가능 */
		data : {
			"key" : key,
			"word" : word,
			"page" : page,
			"perPage" : perPage,
			"order" : order,
			"desc" : desc
		},
		dataType : "json",
		success : function(data) {
			var template = Handlebars.compile($("#temp").html());
			$("#tbl").html(template(data));
			$("#totSum").val(data.totSum);
			$("#ttotSum").val(data.totSum + 3000);

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

// 다음 버튼을 클릭했을때
$("#btnNext").click(function() {
	page++;
	getList();
	$('body,html').animate({
		scrollTop : 300
	}, 500);
	return false;
});

// 이전 버튼을 클릭했을 때
$("#btnPre").click(function() {
	page--;
	getList();
	$('body,html').animate({
		scrollTop : 300
	}, 500);
	return false;
});