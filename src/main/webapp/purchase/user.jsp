<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">구매목록</h1>
		<table class="table table-striped">
			<c:forEach items="${array}" var="vo">
			<tr>
				<td><a href="/purchase/read?pid=${vo.pid}"></a></td>
				<td>${vo.address1} ${vo.address2}</td>
				<td>${vo.phone}</td>
				<td>${vo.purDate}</td>
				<td>${vo.purSum}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>