<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    	.title, .price{
    		font-size:12px;
    	}
    </style>
 <div class = "row">
	<div class = "col">
		<h1 class = "text-center mb-5">쇼핑몰</h1>
		<div class = "row">
			<form name = "frm" class = "col-4">
				<div class = "input-group">
				<input name = "query" class = "form-control" value = "한빛미디어">
				<button class = "btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<hr>
		<div id="div_goods" class="row"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>    	
</div>
<!-- 상품목록 템플릿 -->
<script id="temp_goods" type="x-handlebars-template">
	{{#each .}}
		<div class="col-6 col-md-4 col-lg-2 mb-3">
			<div class="card">
				<div class="card-body">
					<img src="{{image}}" gid="{{gid}}" style="cursor:pointer;" width="100%">
					<div class="ellipsis title mt-2">{{title}}</div>
					<div class="price">{{fmtPrice price}}</div>
				</div>
				<div class="card-footer">
					<i class="bi {{heart ucnt}}" style="color:red;"></i>
					<span style="font-size:0.7rem">{{fcnt}} {{ucnt}}</span>
					<i class="bi bi-chat-right-dots ms-3"></i>
					<span style="font-size:0.7rem">{{rcnt}}</span>
				</div>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
	
	Handlebars.registerHelper("heart", function(ucnt){
		if(ucnt==0) return "bi-suit-heart";
		else return "bi-suit-heart-fill";
	});
</script>
<script>
	let page=1;
	let query="";
	const uid="${user.uid}";
	
	$("#div_goods").on("click", "img", function(){
		const gid=$(this).attr("gid");
		location.href="/goods/read?gid=" + gid;
	});
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{query:query},
			success:function(data){
				const totalPages=Math.ceil(data/12);
				if(totalPages==0){
					alert("검색내용이 존재하지않습니다.");
					$(frm.query).val("");	
					query="";
					getTotal();
				}else{
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);	
				}
			}
		});
	}

	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{page:page, query:query, uid},
			dataType:"json",
			success:function(data){
			console.log(data);
			const temp=Handlebars.compile($("#temp_goods").html());
			$("#div_goods").html(temp(data));
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