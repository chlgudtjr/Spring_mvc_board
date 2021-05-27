<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	$(document).ready(function(event) {
		$(".delete-a").click(function(event){
			event.preventDefault(); // 이벤트를 취소할 때 동작을 멈춘다.
			console.log("ajax 호출전");

			var trObj = $(this).parent();
			console.log(trObj);	
											
			var xhr = $.ajax({
				type : 'DELETE', // AJAX의 타입(삭제)
				url : $(this).attr("href"), // <a>의(this) 속성(href)을 가져온다.(attr)
				cache : false,// 캐시를 false 설정하여 페이지가 새로 고쳐질때 데이터를 남기지 않는다.
				beforeSend : function(xhr) {
				xhr.setRequestHeader("X-CSRF-Token", "${_csrf.token}");
				},
				success : function (result) {
					console.log(result);
					if(result == "SUCCESS"){
						if(confirm("회원정보를 삭제하시겠습니까?") == true){ // 삭제 확인
							$(trObj).remove(); // trObj 변수를 삭제한다.(게시글 삭제)
							console.log("REMOVE");// 삭제 확인
							$(location).attr('href', '${pageContext.request.contextPath }/admin/memberList');// 삭제를 작업 후 리스트로 돌아감
						}else {
							xhr.abort();
						}
					}
				},
				error : function(e) {
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

<title>로그인</title>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-primary navbar-dark">
  <ul class="navbar-nav">
    <li class=" text-white">
     	<h4>ID : ${mbr }</h4>
    </li>
    <li class="nav-item">
    	<button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath }/main'">MAIN</button>
    </li>
    
    <li class="nav-item">
    	<form action="${pageContext.request.contextPath}/logout" method="POST">
      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        	<button class="btn btn-primary" type="submit">LOGOUT</button>
 		</form>
    </li>

   </ul>
</nav>
	<section>
		<table class="table">
			<thead>
				<tr>
					<th>ID</th>
					<th>권한</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${member }" var="member">
					<tr>
						<td>${member.m_id}</td>
						<td>${member.authorities }</td>
						<td><a class="btn btn-primary btn-sm delete-a" href="${pageContext.request.contextPath }/admin/memberList/${member.m_id}/delete">삭제</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>
</body>
</html>