<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5" id="page_cart">
	<div class="col">
		<h1 class="text-center mb-5">장바구니</h1>
		<div id="div_cart"></div>
	</div>
</div>
<jsp:include page="order.jsp"/>

<!-- 카트목록 템플릿 -->
<script id="temp_cart" type="text/x-handlebars-template">
	<table class = "table table-striped">
	<tr>
		<th><input type="checkbox" id="all"></th>
		<th>상품코드</th>
		<th>상품이미지</th>
		<th>상품이름</th>
		<th>상품가격</th>
		<th>상품수량</th>
		<th>상품금액</th>
		<th></th>
	</tr>
	{{#each .}}
	<tr class="tr" price="{{price}}">
		<td><input type="checkbox" class="chk" goods="{{toString @this}}"></td>
		<td class="gid">{{gid}}</td>
		<td><img src="{{image}}" width="50px"></td>
		<td>{{title}}</td>
		<td>{{sum price 1}}</td>
		<td>
			<input class="qnt" value="{{qnt}}" size=5 oninput="isNumber(this)">&nbsp;
			<button class="btn btn-primary btn-sm btn-update">수정</button>
		</td>
		<td>{{sum price qnt}}</td>
		<td><button class="btn btn-danger btn-sm" gid="{{gid}}">삭제</button></td>
	</tr>
	{{/each}}
	<tr>
		<td colspan="8" class="text-end pe-5">
			<h5>총 합계: <span id="sum">0원</span></h5>
		</td>
	</tr>
	</table>
	<div class="text-center my-3">
		<button class="btn btn-primary px-5" id="btn-order">주문하기</button>
	</div>
</script>
<script>
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum=price*qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Handlebars.registerHelper("toString", function(goods){
		return JSON.stringify(goods); //object를 string으로 변환
	});
</script>
<script>
	getList();
	const uid="${user.uid}";
	
	//주문하기 버튼을 클릭한 경우
	$("#div_cart").on("click", "#btn-order", function(){
		if(uid==""){ //로그인이 안 된 경우
			location.href="/user/login?target=/cart/list";
		}else{ //로그인이 된 경우
			const chk=$("#div_cart .chk:checked").length;
			if(chk==0){
				alert("주문할 상품을 선택하세요.")
			}else{
				let data=[];
				$("#div_cart .chk:checked").each(function(){
					const goods=$(this).attr("goods");
					data.push(JSON.parse(goods));
				});
				console.log(data);
				getOrder(data);
				$("#page_order").show();
				$("#page_cart").hide();	
			}
		}
	});
	//전체선택 체크박스를 클릭한 경우
	$("#div_cart").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#div_cart .chk").each(function(){
				$(this).prop("checked",	false);
			});
		}
	});
	
	//각 행의 체크박스를 클릭한 경우
	$("#div_cart").on("click", ".chk", function(){
		const all=$("#div_cart .chk").length;
		const chk=$("#div_cart .chk:checked").length;
		if(all==chk){
			$("#div_cart #all").prop("checked", true);
		}else{
			$("#div_cart #all").prop("checked", false);
		}
	});
	//각 행의 수량 수정버튼을 클릭한 경우
	$('#div_cart').on("click", ".btn-update", function(){
		const row=$(this).parent().parent();
		const gid=row.find(".gid").text();
		const qnt=row.find(".qnt").val();
		if(confirm(gid + "상품의 수량을" + qnt + "로 변경하실래요?")){
			$.ajax({
				type:"get",
				url:"/cart/update",
				data:{gid:gid, qnt:qnt},
				success:function(){
					getList();
				}
			});
		}
	});
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
	
	$("#div_cart").on("click", ".btn-danger", function(){
		const gid=$(this).attr("gid");
		if(confirm(gid + "번 상품을 삭제하실래요?")){
			$.ajax({
				type:"get",
				url:"/cart/delete",
				data:{gid:gid},
				success:function(){
					getList();
				}
			});
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			success:function(data){
				if(data.length==0){
					$("#div_cart").html("<hr><h3 class='text-center'>장바구니가 비어있습니다.</h3>");
				}else{
					const temp=Handlebars.compile($("#temp_cart").html());
					$("#div_cart").html(temp(data));
					getSum();	
				}
			}
		});
		
	}
	
	function getSum(){
		let sum=0;
		$("#div_cart .tr").each(function(){
			const price=$(this).attr("price");
			const qnt=$(this).find(".qnt").val();
			sum += price*qnt;
			console.log(price, qnt);
		});
		$("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}
</script>