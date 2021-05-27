<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>       
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
body {
	font-family: 'Do Hyeon', sans-serif;
}

.nav-item {
	margin-left: 15px;
} 


</style>

<title>게시판 리스트</title>
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
    
    <li class="nav-item" style="position: relative; left: 840px;">
    	<form id="searchForm" class="form-inline" action="${pageContext.request.contextPath }/member/board/list" method="get">
			<span style="float: left;">
				<select class="custom-select" name="type" style="width: 100px;">
					<option value="" <c:out value="${pageMaker.cri.type == null?'selected' : '' }" />>---</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ?'selected' : '' }" />>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ?'selected' : '' }" />>작성자</option>
				</select>
				</span>
				<span style="float: left;">
					<input class="form-control" type="text" name="keyword" style="width: 200px;" value='<c:out value="${pageMaker.cri.keyword}" />' /> 
					<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}" />' /> 
					<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}" />' />
				</span>
				<button class="btn btn-primary">검색</button>
			</form>
		</li>
   </ul>
</nav>
	<table class="table">
		<thead >
			<tr >
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성일자</th>
			</tr>
		</thead>
		
		<tbody >
			<c:forEach items="${list }" var="list">
			<tr>
				<td>${list.bId }</td>
				<td>${list.bName }</td>
				<td>
					<a href="${pageContext.request.contextPath }/member/board/contentView/${list.bId }">${list.bTitle }</a>
				</td>
				<td>${list.bHit }</td>
				<td>${list.bDate }</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="2">
					<button class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath }/member/board/writeView'">글작성</button>&nbsp;&nbsp;
				</td>
			</tr>
		</tbody>
	</table>
	
	<ul class="pagination justify-content-center" style="margin: auto;">
		<c:if test="${pageMaker.prev}">
			<a class="page-link" href="${pageContext.request.contextPath }/member/board/list/${pageMaker.makeQuery(pageMaker.startPage - 1)}">PREV</a>
		</c:if>

		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			<c:out value="${pageMaker.cri.pageNum == index?'':''}" />
			<a class="page-link" href="${pageContext.request.contextPath }/member/board/list/${pageMaker.makeQuery(index)}">${index}</a>
		</c:forEach>

		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<a class="page-link" href="${pageContext.request.contextPath }/member/board/list/${pageMaker.makeQuery(pageMaker.endPage +1)}">NEXT</a>
		</c:if>
	</ul>
	
</body>
</html>