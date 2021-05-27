<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>       
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#modifyForm").submit(function(event) {
			event.preventDefault();
			
			var bId = $("#bId").val();
			var bName = $("#bName").val();
			var bTitle = $("#bTitle").val();
			var bContent = $("#bContent").val();
			
			console.log(bId);
			console.log(bName);
			console.log(bTitle);
			console.log(bContent);
			console.log($(this).attr("action"));
			 
			var form = {
				bId : bId,
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
	            	   if(confirm("수정 하시겠습니까?") == true){ // 작성 확인
							console.log("MODIFY");// 작성 확인
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

<script type="text/javascript">
$(document).ready(function(event){
	$(".a_delete").click(function(event){
		event.preventDefault();
		
		console.log("ajax호출 전");
		
		var tjObj = $(this).parent();
		
		$.ajax({
			type : "DELETE",
			url : $(this).attr("href"),
			cache : false,
			beforeSend : function (xhr) {
				xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
			},
			success : function (result) {
				console.log(result);
				if(result == "SUCCESS"){
					if(confirm("정말 삭제하시겠습니까??") == true){
						console.log("REMOVE");
						 $(location).attr('href', '${pageContext.request.contextPath}/member/board/list');
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

<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
body {
	font-family: 'Do Hyeon', sans-serif;
}

.nav-item {
	margin-left: 15px;
} 

</style>
<title>게시글 수정/삭제</title>
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
		<form id="modifyForm" action="${pageContext.request.contextPath }/member/board/modifyView/${modifyView.bId}/modify" method="put">
			<input type="hidden" name="bId" id="bId" value="${modifyView.bId}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<tr>
				<td>작성자</td>
				<td><input class="form-control" type="text" name="bName" id="bName" value="${modifyView.bName }" disabled="disabled"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input class="form-control" type="text" name="bTitle" id="bTitle" value="${modifyView.bTitle }"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea class="form-control" rows="10" id="bContent" name="bContent">${modifyView.bContent }</textarea></td>
			</tr>
		
			<tr>
				<td colspan="2">
					<button class="btn btn-primary btn-sm" type="submit">수정</button>&nbsp;&nbsp;&nbsp;
					<a class="btn btn-primary btn-sm a_delete" href="${pageContext.request.contextPath }/member/board/modifyView/${modifyView.bId}/delete">삭제</a>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>