<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h3 class = "text-center mb-5">고객리뷰</h3>
		<c:if test="${user==null}">
			<div>
				<button class="btn btn-primary w-50" id="btn-review">리뷰작성</button>
			</div>
		</c:if>
		<c:if test="${user!=null}">
		<form name="frm">
			<textarea name="content" rows="5" class="form-control" placeholder="리뷰내용을 입력하세요."></textarea>
			<div class="text-center mt-2">
			<button class = "btn btn-primary px-5">글쓰기</button>
			</div>
		</form>
		</c:if>
		<div id="div_review" class="my-5"></div>
	</div>
</div>
<!-- 리뷰목록 템플릿 -->
<script id ="temp_reivew" type="x-handlebars-template">
	{{#each .}}
		<div class="row">
			<div class="col-md-1">
				<img src="{{photo}}" width="50px">
				<div>{{uid}}</div>
			</div>
			<div class="col">
				<div>{{revDate}}</div>
				<div>{{content}}</div>	
			</div>
		</div>
		<hr>
	{{/each}}
</script>
<script>

	const uid="${user.uid}";
	const gid="${vo.gid}";
	
	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			data:{gid},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		});
	}
	
	$("#btn-review").on("click", function(){
		location.href="/user/login?target=/goods/read?gid=" + gid;
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const content=$(frm.content).val();
		if(content==""){
			alert("리뷰를 작성해주세요.");
			$(frm.content).focus();
		}else{
			$.ajax({
				type:"post",
				url:"/review/insert",
				data:{gid, uid, content},
				success:function(){
					alert("리뷰가 저장되었습니다.");
					$(frm.content).val("");
					getList();
				}
			});
		}
	});
</script>