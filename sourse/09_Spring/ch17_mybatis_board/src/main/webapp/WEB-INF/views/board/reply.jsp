<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath}/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- reply.jsp : param.pageNum, param.bid, model의 board(원글정보) -->
  <form action="${conPath }/board/reply.do" method="post">
  	<input type="hidden" name="pageNum" value="${param.pageNum }">
  	<input type="hidden" name="bid" value="${param.bid }"><!-- 원글 -->
  	<input type="hidden" name="bgroup" value="${boardDto.bgroup }"><!-- 원글 --> 
  	<input type="hidden" name="bstep" value="${boardDto.bstep }"> <!-- 원글 -->
  	<input type="hidden" name="bindent" value="${boardDto.bindent }"><!-- 원글 -->
		<table>
			<caption>${param.bid }번 글 답글 </caption>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="bname" required="required" autofocus="autofocus" value="${replyResult.bname }">
				</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td>
					<input type="text" name="btitle" required="required" value="[답]${replyResult.btitle }">
				</td>
			</tr>
				<th>본문</th>
				<td>
					<textarea rows="5" cols="20" name="bcontent">${replyResult.bcontent }</textarea>
				</td>
			<tr>
				<td colspan="2">
					<input type="submit" value="답글쓰기" class="btn">
					<input type="reset" value="취소" class="btn" onclick="history.back()">
					<input type="button" value="목록" class="btn" onclick="location.href='${conPath}/board/list.do?pageNum=${param.pageNum }'">
				</td>
			</tr>	
		</table>
	</form>
</body>
</html>