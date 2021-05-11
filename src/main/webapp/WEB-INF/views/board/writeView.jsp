<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>       
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

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
	             success: function (result) {       
	               if(result == "SUCCESS"){
	            	   if(confirm("작성 하시겠습니까?") == true){ // 작성 확인
							console.log("WRITE");// 작성 확인
							$(location).attr('href', '${pageContext.request.contextPath }/board/list');// 작업 후 리스트로 돌아감
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


<title>게시글 보기</title>
</head>
<body>
	<table class="table">
		<form id="writeForm" action="${pageContext.request.contextPath }/board/write" method="PUT">
			<tr>
				<td>작성자</td>
				<td><input type="text" name="bName" id="bName" class="form-control"></td>
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
					<button class="btn btn-primary btn-sm" type="submit">글작성</button>&nbsp;&nbsp;&nbsp;
					<a href="${pageContext.request.contextPath }/board/list" class="btn btn-primary btn-sm">목록보기</a>
				</td>
			</tr>
		</form>
	</table>
</body>
</html>