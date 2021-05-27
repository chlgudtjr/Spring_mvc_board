<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>       
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!-- 댓글 작성 -->
	<script type="text/javascript">
	   	$(document).ready(function(){
	      $("#commentWriteForm").submit(function(event){         
	           event.preventDefault();
	            	
	           var bId = $("#bId").val();
	           var m_id = $("#m_id").val();
	           var comment_content = $("#comment_content").val();
	           
	           console.log(bId);
	           console.log(m_id);
	           console.log(comment_content);
	           console.log($(this).attr("action"));    
	           
	        var form = {
        		bId: bId,
        		m_id: m_id,
        		comment_content: comment_content
  		      };
	
	           $.ajax({
	             type : "POST",
	             url : '${pageContext.request.contextPath}/member/board/contentView/${contentView.bId }',
	             cache : false,
	             contentType:'application/json; charset=utf-8',
	             data: JSON.stringify(form), 
	             beforeSend : function(xhr) {
						xhr.setRequestHeader("X-CSRF-Token", "${_csrf.token}");
	             },
	             success: function (result) {       
	            	 if (confirm("댓글을 작성하시겠습니까??") == true) {
		        			console.log("SUCCESS!")  
		        			$(location).attr('href', '${pageContext.request.contextPath}/member/board/contentView/${contentView.bId}');
		        		}else {
							return;
						}                     
	             },
	             error: function (e) {
	                 console.log(e);
	                 alert('댓글 업로드에 실패하였습니다.');
	                 location.reload(); // 실패시 새로고침하기
	             }
	         })            
	       });       
	   	});
	</script>
	
	<!-- 댓글 수정 -->
	<script type="text/javascript">
	   	$(document).ready(function(){
	      $("#commentUpdateForm").submit(function(event){         
	           event.preventDefault();
	            	
	           var comment_id = $("#comment_id").val();
	           var comment_content = $("#c_content").val();
	           
	           console.log(comment_id);
	           console.log(comment_content);
	           console.log($(this).attr("action"));    
	           
	        var form = {
	        	comment_id: comment_id,
	        	comment_content: comment_content
  		      };
	
	           $.ajax({
	             type : "PUT",
	             url : '${pageContext.request.contextPath}/member/board/contentView/${contentView.bId }/modify',
	             cache : false,
	             contentType:'application/json; charset=utf-8',
	             data: JSON.stringify(form), 
	             beforeSend : function(xhr) {
				 xhr.setRequestHeader("X-CSRF-Token", "${_csrf.token}");
	             },
	             success: function (result) {       
	            	 if (confirm("댓글을 수정하시겠습니까??") == true) {
		        			console.log("SUCCESS!")  
		        			$(location).attr('href', '${pageContext.request.contextPath}/member/board/contentView/${contentView.bId}');
		        		}else {
							return;
						}                     
	             },
	             error: function (e) {
	                 console.log(e);
	                 alert('댓글 수정에 실패하였습니다.');
	                 location.reload(); // 실패시 새로고침하기
	             }
	         })            
	       });       
	   	});
	</script>
	
	<!-- 댓글삭제 -->
	<script type="text/javascript">
	$(document).ready(function(event) {
		$(".cmnt_del").click(function(event){
			event.preventDefault(); // 이벤트를 취소할 때 동작을 멈춘다.
			console.log("ajax 호출전");

			var trObj = $(this).parent();
			console.log(trObj);	
											
			$.ajax({
				type : 'DELETE', // AJAX의 타입(삭제)
				url : $(this).attr("href"), // <a>의(this) 속성(href)을 가져온다.(attr)
				cache : false,// 캐시를 false 설정하여 페이지가 새로 고쳐질때 데이터를 남기지 않는다.
				beforeSend : function(xhr) {
				xhr.setRequestHeader("X-CSRF-Token", "${_csrf.token}");
				},
				success : function (result) {
					console.log(result);
					if(result == "SUCCESS"){
						if(confirm("댓글을 삭제하시겠습니까?") == true){ // 삭제 확인
							$(trObj).remove(); // trObj 변수를 삭제한다.(게시글 삭제)
							console.log("REMOVE");// 삭제 확인
							$(location).attr('href', '${pageContext.request.contextPath }/member/board/contentView/${contentView.bId}');// 삭제를 작업 후 리스트로 돌아감
						}else {
							return;
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


<title>게시글 보기</title>
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
				<td>${contentView.bName }</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>${contentView.bTitle}</td>
			</tr>
			<tr>
				<td>작성일자</td>
				<td>${contentView.bDate }</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" class="form-control" name="bContent" id="bContent" readonly="readonly">${contentView.bContent }</textarea></td>
			</tr>	
			<tr>
				<td colspan="5">
					<div class="form-group">
						<div class="col-md-2" style="text-align: center; margin: auto;"><h5>COMMENT</h5></div><br/>
						<form id="commentWriteForm" method="post">
							<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" /> 
							<input type="hidden" id="bId" name="bId" value="${contentView.bId}">
							<input type="hidden" id="m_id" name="m_id" value="${mbr}">
							
							<div class="container">
								<div class="row" align="left">
									<div class="col-md-10" align="left">
										<textarea class="form-control" cols="100" id="comment_content" name="comment_content" placeholder="댓글을 남겨주세요"></textarea>
									</div>
									<div class="col-md-2" style="margin: auto; text-align: center;">
										<button type="submit" class="btn btn-primary" style="width: 100px; height: 50px;">등록</button>
									</div>
								</div>
							</div>
						</form>
					</div>
					<!-- 댓글 불러오기 -->
					<div class="container">
							<c:forEach items="${comment}" var="comment" varStatus="cmnt_status">
							<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" /> 
								<div style="margin: 1% 3% 1% 3%; padding: 1% 3% 1% 3%; border: 1px solid #E5E5E5;">
									<input type="hidden" name="comment_id" value="${comment.comment_id }">
									<span style="font-size: 22px;">${comment.m_id}</span>
									<span> - ${comment.comment_date}</span>
									<div class="col-md-12" align="left">${comment.comment_content}</div>
									<%-- 댓글 작성자가 로그인 한 회원과 일치하지 않을 때 --%> 
									<c:choose>
						   		    	<c:when test="${mbr ne comment.m_id}">
						    			</c:when>
						    		<c:otherwise>
									<div align="right">
										<a class="btn btn-danger btn-sm cmnt_del" href="${pageContext.request.contextPath }/member/board/contentView/${contentView.bId}/delete/${comment.comment_id}">삭제</a>
										&nbsp;&nbsp;
										<!-- Button to Open the Modal -->
										<button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal" style="float: right;">수정</button>
										<form id="commentUpdateForm" method="post">
											<input type="hidden" name="comment_id" id="comment_id" value="${comment.comment_id}">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

												<!-- The Modal -->
												<div class="modal" id="myModal">
													<div class="modal-dialog">
														<div class="modal-content">

															<!-- Modal Header -->
															<div class="modal-header">
																<h4 class="modal-title">댓글 수정</h4>
															</div>

															<!-- Modal body -->
															<div class="modal-body">
																<textarea class="form-control" id="c_content" name="c_content">${comment.comment_content}</textarea>
															</div>

															<!-- Modal footer -->
															<div class="modal-footer">
																<button type="submit" class="btn btn-success" >수정</button>
																<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
															</div>

														</div>
													</div>
												</div>
											</form>
									</div>
									</c:otherwise>
								</c:choose>								
							</div>
						</c:forEach>
					</div>
				</td>
			</tr>
			<c:choose>
				<c:when test="${mbr ne contentView.bName}">
				</c:when>
			<c:otherwise>
			<tr>
				<td colspan="2">
					<button class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/member/board/modifyView/${contentView.bId }'">수정/삭제</button>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>