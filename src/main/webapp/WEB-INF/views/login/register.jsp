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
<script type="text/javascript">
$(document).ready(function() {
	$('#joinForm').submit(function(event) {
		event.preventDefault();
		
		var m_id = $('#m_id').val();
		var m_pw = $('#m_pw').val();
		
		console.log(m_id);
		console.log(m_pw);
		
		var form = {
			m_id : m_id,
			m_pw : m_pw,
		};
		
		$.ajax ({
			type : 'POST',
			url : $(this).attr("action"),
			cache : false,
			contentType:'application/json; charset=utf-8',
            data: JSON.stringify(form),
            beforeSend : function(xhr) {
	   		xhr.setRequestHeader("X-CSRF-Token", "${_csrf.token}");
	        },
			success : function (result) {
				if(result == 'SUCCESS'){
					if(confirm("회원가입을 하시겠습니까?") == true){
						console.log('JOIN SUCCESS');
						$(location).attr('href', '${pageContext.request.contextPath}/login')
					} else {
						return;
					}
				}
			},
			error : function (e) {
				console.log(e);
			}
		})
	});
});
</script>



<title>회원가입</title>
</head>
<body>
	<section class="login-form">
		<h1>MEMBER SIGN UP</h1>
		<form id="joinForm" action="${pageContext.request.contextPath}/signup/join" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="int-area">
				<input type="text" name="m_id" id="m_id" autocomplete="off" required="required" style="width : 85%">
				<label for="m_id">ID</label>
				<span class="id-area"><button type="button" id="idChk" onclick="idCheck()">중복체크</button></span>				
			</div>
			<script type="text/javascript" charset="utf-8">
				function idCheck() {

					var isID = /^[a-zA-Z0-9-_!]{4,12}$/;
					var m_id = $("#m_id").val();

					if (!isID.test(m_id)) {
						alert("아이디 형식을 확인해주세요");
						$("#m_id").focus();
					} else {
						$.ajax({
							url : '${pageContext.request.contextPath}/signup/idCheck',
							type : 'GET',
							data : {
								'm_id' : $('#m_id').val()
							},
							dataType : 'html',
							success : function(data) {
								alert(data);
							}
						});
					}
				}
			</script>
			
			<div class="int-area">
				<input type="password" name="m_pw" id="m_pw" autocomplete="off" required="required" onchange="isSame()">
				<label for="m_pw">PW</label>				
			</div>
			
			<div class="int-area">
				<input type="password" name="pw_c" id="pw_c" autocomplete="off" required="required" onchange="isSame()">
				<label for="pw_c">PW확인</label>				
			</div>
			<span id="check"></span>
			<script type="text/javascript">
				function isSame() {

					var pw = $("m_pw").val();
					var pw_c = $("pw_c").val();

					if (pw != "" || pw_c != "") {
						if (document.getElementById('m_pw').value == document
								.getElementById('pw_c').value) {
							document.getElementById('check').innerHTML = '비밀번호 일치';
							document.getElementById('check').style.color = 'green';
						} else {
							document.getElementById('check').innerHTML = '비밀번호 불일치';
							document.getElementById('check').style.color = 'red';
						}
					}
				}
			</script>
			
			<div class="btn-area">
				<button id="btn" type="submit">SIGN UP</button>
			</div>
			
			<div class="btn-area">
				<button id="btn" type="button" onclick="location.href='${pageContext.request.contextPath}/login'">LOGIN</button>
			</div>
			
		</form>
	</section>
</body>
</html>