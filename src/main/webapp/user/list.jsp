<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">회원목록</h1>
		<div class="row">
			<form class="col-6" name="frm">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="uid">아이디</option>
						<option value="uname" selected>회원이름</option>
						<option value="address1">회원주소</option>
						<option value="phone">회원전화</option>
					</select>&nbsp;
					<input class="form-control" placeholder="검색어" name="query">
					<input type="submit" value="검색" class="btn btn-primary">
				</div>
			</form>
		</div>
		<hr>
		<div id="div_user"></div>
	</div>
</div>
<!-- 회원목록 템플릿 -->
<script id="temp_user" type="x-handlebars-template">
	{{#each .}}
	<div class="card p-3 mb-3">
		<div class="row">
			<div class="col-2 col-md-2">
				<img src="{{photo}}" width="90%">
			</div>
			<div class="col">
				<div>{{uname}} ({{uid}})</div>
				<div>{{address1}} {{address2}}</div>
				<div>{{phone}}</div>
			</div>
		</div>
	</div>
	{{/each}}
</script>
<script>
	let page=1;
	let query=$(frm.query).val();
	let key=$(frm.key).val();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		key=$(frm.key).val();
		getList();
	});
	
	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"/user/list.json",
			data:{key:key,query:query, page:page},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_user").html());
				$("#div_user").html(temp(data));
			}
		});
	}
</script>