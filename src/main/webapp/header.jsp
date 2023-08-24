<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<div class="col">
		<img src="/image/header01.jpg" width="100%" id="img_header">
		<div class="mt-3">
			<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">쇼핑몰</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">	
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<c:if test="${user.role==1}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/goods/search">상품검색</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/goods/list">상품목록</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/list">회원목록</a>
							</li >
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/purchase/list">구매목록</a>
							</li>
						</c:if>
						<c:if test="${user.role==2 || user==null}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/cart/list">장바구니</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/purchase/user">구매목록</a>
							</li>
						</c:if>
					</ul>
					<ul class="navbar-nav  mb-2 mb-lg-0">
						<c:if test="${user==null}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/login">로그인</a>
							</li>
						</c:if>
						<c:if test="${user!=null}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/read">${user.uname}님</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/logout">로그아웃</a>
							</li>
						</c:if>
					</ul>		
				</div>
			</div>
		</nav>
	</div>
</div>
</div>
