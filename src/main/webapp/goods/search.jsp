<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class = "row my-5">
	<div class = "col">
		<h1 class = "text-center mb-5">상품검색</h1>
		<div class = "row justify-content-end">
			<form name = "frm" class = "col-4">
				<div class = "input-group">
				<input name = "query" class = "form-control" value = "한빛미디어">
				<button class = "btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<hr>
		<div id = "div_search"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>
<!--검색목록 템플릿-->
<script id = "temp_search">
<table class = "table table-striped">
	{{#each items}}
		<tr goods = "{{toString @this}}">
			<td><img src="{{image}}" width="50px"></td>
			<td class = "title">{{{title}}}</td>
			<td>{{lprice}}</td>
			<td>{{maker}}</td>
			<td><button class = "btn btn-primary btn-sm btn-save">저장</button></td>
		</tr>
	{{/each}}
</table>
</script>
<script>
	Handlebars.registerHelper("toString", function(goods){
		return JSON.stringify(goods); //object -> String
	});
</script>
<script>
	let page = 1;
	let query = "한빛미디어";
	
	getList();
	
	//각행의 저장버튼을 클릭한 경우
	$("#div_search").on("click", ".btn-save", function(){
		const row = $(this).parent().parent();
		const goods = JSON.parse(row.attr("goods")); //String => object
		const title = row.find(".title").text();
		
		if(confirm(title +" 상품을 저장하실래요?")){
			goods["title"]=title;
			//console.log(goods);
			$.ajax({
				type : "post",
				url : "/goods/append",
				data : goods,
				success : function(){
					alert("상품이 저장 되었습니다.")
				}
			});
		}
	});
	$(frm).on("submit", function(e){
		e.preventDefault();
		query = $(frm.query).val();
		if(query == ""){
			alert("검색어를 입력하세요.");
			$(frm.query).focus();
		}else{
			page =1;
			getList();
		}
	});
	function getList(){
		$.ajax({
			type : "get",
			url : "/goods/search.json",
			data : {page:page, query:query},
			dataType : "json",
			success : function(data){
				console.log(data);
				const temp = Handlebars.compile($("#temp_search").html());
				const html = temp(data);
				$("#div_search").html(html);
			}
		});
	}
	
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) {
	    	page=curPage;
	    	getList();
	    }
	});
	
	
</script>