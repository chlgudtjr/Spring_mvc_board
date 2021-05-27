<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="resources/css/stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>로그인</title>
</head>
<body>
	<section class="login-form">
		<h1>LOGIN</h1>
		<form action="${loginUrl}" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="int-area">
				<input type="text" name="m_id" id="m_id" autocomplete="off" required>
				<label for="m_id">ID</label>				
			</div>
			
			<div class="int-area">
				<input type="password" name="m_pw" id="m_pw" autocomplete="off" required>
				<label for="m_pw">PW</label>				
			</div>
			<div class="a-area">
				<a href="${pageContext.request.contextPath}/signup">SIGN UP</a>
			</div>
			<br/>
			<div class="btn-area">
				<button id="btn" type="submit">LOGIN</button>
			</div>
				<!-- 로그인 실패 시 오류 메세지 -->
				<c:if test="${error}">
					<div class="error-area">
						<p>${exception}</p>
					</div>
				</c:if>
		</form>
	</section>
	
	<script type="text/javascript">
		var id = $('#m_id');
		var pw = $('#m_pw');
		var btn = $('#btn');
		
		$(btn).on('click', function() {
			if($(id).val() == "") {
				$(id).next('label').addClass('warning');
				setTimeout(function () {
					$('label').removeClass('warning');
				}, 1500);
			} else if ($(pw).val() == "") {
				$(pw).next('label').addClass('warning');
			}
		})
	</script>
</body>
</html>