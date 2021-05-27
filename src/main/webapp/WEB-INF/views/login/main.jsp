<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="resources/css/stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<title>메인 홈페이지</title>
</head>
<body>
	<section class="login-form">
		<div class="head-area">
			<p>WELCOME HOME!</p>
		</div>
		
		<div class="m-area">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<p> ${mbr} 님 환영합니다!</p>
		</div>
		
		<div class="btn-area-two">
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/board/list'">게시판</button>
			<form action="${pageContext.request.contextPath}/logout" method="POST">
      			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        		<button type="submit">LOGOUT</button>
 		    </form>
 		    <sec:authorize access="hasAuthority('ADMIN')">
 		    	<button onclick="location.href='${pageContext.request.contextPath}/admin/memberList'">MEMBER LIST</button>
 		    </sec:authorize>
		</div>
	</section>

</body>
</html>