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

<title>게시판 리스트</title>
</head>
<body>
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
					<c:forEach begin="1" end="${list.bIndent }">-</c:forEach>
					<a href="${pageContext.request.contextPath }/board/contentView/${list.bId }">${list.bTitle }</a>
				</td>
				<td>${list.bHit }</td>
				<td>${list.bDate }</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="2">
					<a href="${pageContext.request.contextPath }/board/writeView" class="btn btn-primary btn-sm">글작성</a>
				</td>
			</tr>
		</tbody>
	</table>
	
	<ul class="pagination justify-content-center" style="margin: auto;">
		<c:if test="${pageMaker.prev}">
			<a class="page-link" href="${pageContext.request.contextPath }/board/list/${pageMaker.makeQuery(pageMaker.startPage - 1)}">PREV</a>
		</c:if>

		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			<c:out value="${pageMaker.cri.pageNum == index?'':''}" />
			<a class="page-link" href="${pageContext.request.contextPath }/board/list/${pageMaker.makeQuery(index)}">${index}</a>
		</c:forEach>

		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<a class="page-link" href="${pageContext.request.contextPath }/board/list/${pageMaker.makeQuery(pageMaker.endPage +1)}">NEXT</a>
		</c:if>
	</ul>
	
</body>
</html>