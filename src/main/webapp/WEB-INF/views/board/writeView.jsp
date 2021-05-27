<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>       
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#writeForm").submit(function(event) {
			event.preventDefault();
			
			var bName = $("#bName").val();
			var bTitle = $("#bTitle").val();
			var bContent = $("#bContent").val();
			
			console.log(bName);
			console.log(bTitle);
			console.log(bContent);
			console.log($(this).attr("action"));
			 
			var form = {
				bName : bName,
				bTitle : bTitle,
				bContent : bContent
			};
			
			$.ajax({
				type : "PUT",
				 url : $(this).attr("action"),
	             cache : false,
	             contentType:'application/json; charset=utf-8',
	             data: JSON.stringify(form),
	             beforeSend : function(xhr) {
	 	   		 xhr.setRequestHeader("X-CSRF-Token", "${_csrf.token}");
	 	         },
	             success: function (result) {       
	               if(result == "SUCCESS"){
	            	   if(confirm("작성 하시겠습니까?") == true){ // 작성 확인
							console.log("WRITE");// 작성 확인
							$(location).attr('href', '${pageContext.request.contextPath }/member/board/list');// 작업 후 리스트로 돌아감
						}else {
							return;
						}                           
	                }                       
	             },
	             error: function (e) {
	                 console.log(e);
	             }
			})
		});
	});
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
body {
	font-family: 'Do Hyeon', sans-serif;
}

.nav-item {
	margin-left: 15px;
} 


</style>

<title>게시글 작성</title>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-primary navbar-dark">
  <ul class="navbar-nav">
    <li class=" text-white">
     	<h4>ID : ${mbr }</h4>
    </li>
    <li class="nav-item">
    	<button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath }/member/board/list'">LIST</button>
    </li>
    
    <li class="nav-item">
    	<form action="${pageContext.request.contextPath}/logout" method="POST">
      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        	<button class="btn btn-primary" type="submit">LOGOUT</button>
 		</form>
    </li>
   </ul>
</nav>
	<table class="table">
		<form id="writeForm" action="${pageContext.request.contextPath }/member/board/write" method="PUT">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<tr>
				<td>작성자</td>
				<td><input type="text" name="bName" id="bName" class="form-control" value="${mbr }" disabled="disabled"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="bTitle" id="bTitle" class="form-control"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" name="bContent" id="bContent" class="form-control"></textarea></td>
			</tr>
		
			<tr>
				<td colspan="2">
					<button class="btn btn-primary btn-sm" type="submit">글작성</button>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>