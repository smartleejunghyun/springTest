<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
$(document).ready(()=>{
	$("button").click(function(){
		const oper = $(this).data("oper");
		const frmObj = $("#frm");
		if(oper=='modify'){
			$("#frm").attr('method',"post");
			$("#frm").attr('action',"${cpath}/board/modify");
		}else if(oper=='list'){
			$("#frm").attr('action',"${cpath}/board/list");
		}else{
			frmObj[0].reset();
			return;
			
		}
		frmObj.submit();
	});
});
</script>
</head>
<body>

	<div class="container">
		<h2></h2>
		<div class="panel panel-default">
			<div class="panel-heading">BOARD VIEW</div>
			<div class="panel-body">
				<form id="frm" class="form-horizontal">
				<input type="hidden" name="idx" value="${vo.idx}">
				<input type="hidden" name=page value="${cri.page}">
				<input type="hidden" name=perPageNum value="${cri.perPageNum}">
				<input type="hidden" name="type" value="${cri.type}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
					<!-- Lable/input 한 쌍 -->
					<div class="form-group">
						<label class="control-label col-sm-2" for="email">제목:</label>
						<div class="col-sm-10">
							<input type="text" name="title" class="form-control" value="${vo.title}">
								
						</div>
					</div>

					<!-- 내용이 들어가는 부분 -->
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">내 용:</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="10" name="content" >${vo.content}</textarea>
						</div>
					</div>



					<!-- Lable/input 한 쌍 -->
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">작성자:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="${vo.writer }"
								readonly="readonly">
						</div>
					</div>



					<!-- 버튼 -->
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" data-oper="modify" class="btn btn-default">완료</button>
							<button type="reset" data-oper="reset" class="btn btn-default">취소</button>
							<button type="button" data-oper="list" class="btn btn-default">목록으로</button>
						</div>
					</div>
				</form>
			</div>
			<div class="panel-footer">빅데이터 분석 서비스 개발자 과정</div>
		</div>
	</div>


</body>
</html>
