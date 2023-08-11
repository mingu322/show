<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class = "row my-5">
	<div class = "col">
		<h1 class = "text-center mb-5">상품정보</h1>
		<div class = "row">
			<div class = "col-md-5 m-2">
				<img src="${vo.image}" width = "90%">
			</div>
			<div class = "col card m-2 p-3">
				<h5>상품코드: ${vo.gid}</h5>
				<h5>상품이름: ${vo.title}</h5>
				<hr>
				<div class = "my-2">상품가격: <fmt:formatNumber value="${vo.price}" pattern="#,###원"/></div>
				<div class = "my-2">제조사: ${vo.maker}</div>
				<div class = "my-2">상품등록일: ${vo.regDate}</div>
				<hr>
				<div> 
					<button class = "btn btn-primary" id="btn-cart" gid="${vo.gid}">장바구니</button>
					<button class = "btn btn-warning">바로구매</button>
				</div>
			</div>
		</div>
	</div>
</div>	 	
<jsp:include page="review.jsp"/>
<script>
	$("#btn-cart").on("click", function(){
		const gid=$(this).attr("gid");
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{gid:gid},
			success:function(){
				if(confirm("계속 쇼핑하실래요?")){
					location.href="/";
				}else{
					location.href="/cart/list";
				}
			}
		});
	});
</script>