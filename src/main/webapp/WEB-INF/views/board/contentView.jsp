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
	$(document).ready(function(event) {
		$("#delete").click(function(event){
			event.preventDefault(); // 이벤트를 취소할 때 동작을 멈춘다.
			console.log("ajax 호출전");
			// <a>의 parent(<td>)의 parent 즉, <tr>를 지칭한다.(클로저)
			/*
				어떻게 제이쿼리는 this가 <a>인 것을 알고있을까?
				: a 태그내 .a-delete 클릭 이벤트가 발생 되었으므로!
				: $('.a-delete').click(function(event)
			 */
			var trObj = $(this).parent().parent();
			
			$.ajax({
				type : 'DELETE', // AJAX의 타입(삭제)
				url : $(this).attr("href"), // <a>의(this) 속성(href)을 가져온다.(attr)
				cache : false,// 캐시를 false 설정하여 페이지가 새로 고쳐질때 데이터를 남기지 않는다.
				success : function (result) {
					console.log(result);
					if(result == "SUCCESS"){
						if(confirm("정말 삭제하시겠습니까?") == true){ // 삭제 확인
							$(trObj).remove(); // trObj 변수를 삭제한다.(게시글 삭제)
							console.log("REMOVE");// 삭제 확인
							$(location).attr('href', '${pageContext.request.contextPath }/board/list');// 삭제를 작업 후 리스트로 돌아감
						}else {
							return;
						}
					},
				error : function(e) {
					console.log(e);
				}
			})
		});
	});
</script>

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
	             success: function (result) {       
	               if(result == "SUCCESS"){
	            	   if(confirm("수정 하시겠습니까?") == true){ // 작성 확인
							console.log("MODIFY");// 작성 확인
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
	<form id="modifyForm" action="${pageContext.request.contextPath }/board/modify" method="PUT">
		<input type="hidden" name="bId" id="bId" value="${contentView.bId }">
		<tbody >
			<tr>
				<td>번호</td>
				<td>${contentView.bId }</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${contentView.bHit }</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input class="form-control" type="text" name="bName" id="bName" value="${contentView.bName }"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input class="form-control" type="text" name="bTitle" id="bTitle" value="${contentView.bTitle}"></td>
			</tr>
			<tr>
				<td>작성일자</td>
				<td>${contentView.bDate }</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" class="form-control" name="bContent" id="bContent">${contentView.bContent }</textarea></td>
			</tr>
		
			<tr>
				<td colspan="2">
					<button class="btn btn-primary btn-sm" type="submit">수정</button>&nbsp;&nbsp;&nbsp;
					<a id="delete" class="btn btn-primary btn-sm" href="${pageContext.request.contextPath }/board/contentView/${contentView.bId }">삭제</a>&nbsp;&nbsp;&nbsp;
					<button class="btn btn-primary btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath }/board/replyView/${contentView.bId }'">답번</button>&nbsp;&nbsp;&nbsp;
					<button class="btn btn-primary btn-sm" type="button" onclick="location.href='${pageContext.request.contextPath }/board/list'">목록보기</button>
				</td>
			</tr>
		</tbody>
		</form>
	</table>
</body>
</html>