<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>게시판 리스트</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.c	om/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<script>
	$(document)
			.ready(
					function() {
						const result = '${result}';
						checkModal(result);

						$(".del").on("click", function(e) {
							e.preventDefault();
							var idx = $(this).attr("href");
							alert(idx + "번의 게시물은 삭제되었습니다.");
							return;
						});

						//페이지 번호 클릭시 이동
						var pageForm = $("#pageForm");
						$(".paginate_button a").on("click", function(e) {
							e.preventDefault();
							var page = $(this).attr("href");
							//form - hidden
							pageForm.find("#page").val(page);
							pageForm.submit();

							//location.href="${cpath}/board/list1?page="+page; -> 틀린건 아니지만 url이 너무 길어짐
						});

						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											var idx = $(this).attr("href")
											pageForm
													.append(`<input type='hidden' id='idx' name='idx' value='${idx}'>`)
											pageForm.find('#idx').val(idx);
											pageForm.attr('action',
													'${cpath}/board/get')
											pageForm.submit();
										})

					});
	function checkModal(result) {
		if (result == '') {
			return;
		}
		if (parseInt(result) > 0) {
			$(".modal-body").html("<font color='red'>삭제완료</font>");
			$("#myModal").modal("show");
		}
	}
</script>

</head>
<body>


	<div class="container">
		<h2></h2>
		<div class="panel panel-default">
			<div class="panel-heading">
				<c:choose>
					<c:when test="${empty mvo}">
						<form class="form-inline" method="post"
							action="${cpath}/board/login">
							<div class="form-group">
								<label for="email">ID :</label> <input type="text"
									class="form-control" name="memId">
							</div>
							<div class="form-group">
								<label for="pwd">Password:</label> <input type="password"
									class="form-control" name="memPwd">
							</div>


							<button type="submit" class="btn btn-default">로그인</button>
						</form>
					</c:when>
					<c:otherwise>
						<form class="form-inline" method="get"
							action="${cpath}/board/logout">
							<div class="form-group">
								<label>${mvo.getMemName()}님 방문을 환영합니다!!</label>
							</div>

							<button type="submit" class="btn btn-default">로그아웃</button>
						</form>
					</c:otherwise>
				</c:choose>

			</div>
			<div class="panel-body">
				<table class="table table-bordered table-hover">
					<tr class="success">
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
					<c:forEach var="vo" items="${list}">
						<tr>
							<td>${vo.bgroup+1}</td>
							<td><c:if test="${vo.blevel>0}">
									<c:forEach begin="1" end="${vo.blevel}">
										<span style="padding-left: 17px"></span>
									</c:forEach>
									<c:if test="${vo.bdelete == 1}">
										<a class="move" href="${vo.idx}"><i
											class="bi bi-arrow-return-right"></i> ${vo.title} </a>
									</c:if>

									<c:if test="${vo.bdelete == 0}">
										<a class="del" href="${vo.idx}"><i
											class="bi bi-arrow-return-right"></i> 삭제된 게시물입니다. </a>
									</c:if>
								</c:if> <c:if test="${vo.blevel eq 0}">
									<c:if test="${vo.bdelete == 1}">
										<a class="move" href="${vo.idx}">${vo.title}</a>
									</c:if>

									<c:if test="${vo.bdelete == 0}">
										<a class="del" href="${vo.idx}">삭제된 게시물입니다.</a>
									</c:if>
								</c:if></td>
							<td>${vo.writer}</td>
							<td>${fn:split(vo.indate, " ")[0]}</td>
							<td>${vo.count}</td>
						</tr>
					</c:forEach>
				</table>
				<c:if test="${!empty mvo}">
					<button class="btn btn-sm btn-success"
						onclick="location.href='${cpath}/board/register'">
						글쓰기 <i class="bi bi-pencil-fill" style="margin-left: 5px;"></i>
					</button>
				</c:if>
			</div>


			<form id="pageForm" action="${cpath}/board/list" method="get">
				<input type="hidden" id="page" name="page"
					value="${pageMaker.cri.page}"> <input type="hidden"
					id="perPageNum" name="perPageNum"
					value="${pageMaker.cri.perPageNum}"> <input type="hidden"
					class="form-control" name="keyword"
					value="${pageMaker.cri.keyword}" /> <input type="hidden"
					class="form-control" name="type" value="${pageMaker.cri.type}" />

			</form>
			
			<!-- 검색 메뉴 -->
			<div style="text-align: center;">
				<form class="form-inline" action="${cpath}/board/list" method="post">
					<div class="form-group">
						<select class="form-control" name="type">
							<option value="writer"
								${pageMaker.cri.type=='writer'? 'selected' : '' }>이름</option>
							<option value="title"
								${pageMaker.cri.type=='title'? 'selected' : '' }>제목</option>
							<option value="content"
								${pageMaker.cri.type=='content'? 'selected' : '' }>내용</option>
						</select>
					</div>
					<div class="form-group">

						<input type="text" class="form-control" name="keyword"
							value="${pageMaker.cri.keyword}" />
					</div>
					<button type="submit" class="btn btn-sm btn-success">검색</button>


				</form>
			</div>
			<!-- 검색 메뉴 끝  -->


			<!-- 페이징 처리 -->
			<div style="text-align: center">
				<!-- 페이지 번호 출력 -->
				<div class="container mt-3">
					<ul class="pagination">
						<c:if test="${pageMaker.prev eq true }">
							<li class="paginate_button previous"><a class="page-link"
								href=${pageMaker.startPage-1}>◀</a></li>
						</c:if>
						<c:forEach var="pageNum" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">
							<li
								class="paginate_button ${pageMaker.cri.page==pageNum ? 'active' : '' }"><a
								class="page-link" href="${pageNum}">${pageNum}</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next eq true }">
							<li class="paginate_button next"><a class="page-link"
								href=${pageMaker.endPage+1}>▶</a></li>
						</c:if>
					</ul>
				</div>


			</div>
			<!-- 페이징 처리 끝 -->
			<div class="panel-footer">빅데이터 분석 서비스 개발자 과정</div>
		</div>
	</div>


	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Modal Heading</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body"></div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<script>
		/* const del = document.querySelectorAll('.del');
		console.log(del);
		function Del(e){
			e.preventDefault();
			
			$(".modal-body").html(`<font color="red">삭제되었습니다.</font>`)
			$("#myModal").modal("show");
			
		}
		
		
		del.forEach((e)=>e.addEventListener('click', Del));
		 */
		/* 	 $(".del").on("click", function(e){
		 e.preventDefault();
		 var idx=$(this).attr("href");
		 alert(idx+"번의 게시물은 삭제되었습니다.");
		 return;
		 });
		
		
		 */
	</script>
</body>
</html>
