<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String name  = request.getParameter("name");
	String id 	 = request.getParameter("id");
	String pw 	 = request.getParameter("pw");
	String birth = request.getParameter("birth");
	/* Date birth = Date.valueOf(request.getParameter("birth"));
	Timestamp birthTimestamp = Timestamp.valueOf(request.getParameter("birth")+" 00:00:00"); */
	/* 생년월일 입력 안 할시 오류 잡기 */
	Date birthDate = null;	
	Timestamp birthTimestamp = null;
	if(birth!=null && !birth.equals("")){
		birthDate = Date.valueOf(birth);
		birthTimestamp = Timestamp.valueOf(birth + " 00:00:00");
	}
	String[] hobby = request.getParameterValues("hobby");
	String gender  = request.getParameter("gender");
	String email	 = request.getParameter("email");
	String[] mailSend = request.getParameterValues("mailSend");
	// 받은 파라미터 값을 Member DB에 저장
%>
	<script>
		alert('<%=name%> 님 회원가입 완료되었습니다. 감사합니다');
		location.href='login.jsp';
	</script>
<%-- 	<jsp:include page="../member/header.jsp"/>
	<div id="joinForm_wrap">
	<div id="join_title">회원가입정보</div>
	<h2>name : <%=name %></h2>
	<h3>id : <%=id %></h3>
	<h3>pw : <%
				for(int i=0 ; i< pw.length() ; i++){
					out.print('*');
				}%></h3>
	<h3>pw : <%=pw.replaceAll("[a-zA-Z0-9~`!@#$%^&*()\\-_+=|\\{}\\[\\]:;\"'?/<>,\\.]", "*") %></h3>
	<h3>birth : <%=birth %></h3>
	<h3>birth : <%=birthTimestamp %></h3>
	<h3>hobby : <% 
			if(hobby!=null) {
				for(int i=0 ; i<hobby.length ; i++)
					if(i==hobby.length-1)
						out.print(hobby[i]);
					else
						out.print(hobby[i]+", ");
			}else {
				out.print("없음");
			}
	%></h3>
	<h3>gender : <%=gender %></h3>
	<h3>email : <%=email %></h3>
	<h3>mailSend : <%
			if(mailSend!=null){
				out.print(Arrays.toString(mailSend));
			}else{
				out.print("모두 수신 거부");
			}
	%></h3>
	<h3>가입일 : <%=new Date(System.currentTimeMillis()) %></h3>
	<h3>가입IP : <%=request.getRemoteAddr() %></h3>
	<input type="button" value="로그인" class="joinBtn_style" 
											onclick="location.href='<%=conPath%>/member/login.jsp'">
</div>
	<jsp:include page="../member/footer.jsp"/> --%>
</body>
</html>