<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Custom Login Page</h1>
	<h2><c:out value="${error }" /></h2>
	<h2><c:out value="${logout }" /></h2>

	<!-- 
			> CUSTOM LOGIN
			- form method, action = post, /login으로 지정
			- name 속성: username, password 이용
			- input:hidden의 name은 _csrf, value값은 임의의 값이 지정된다.
			- 로그인 실패시 다시 로그인 페이지로 이동
			
			> CSFR(Cross-site request forgery)
			- '사이트간 요청 위조'
			- token은 임의생성되서 공격자의 입장에서는 token번호를 알아야 공격 가능
	 -->	
	<form method='post' action="/login">
	
	<div>
		<input type='text' name='username' value='admin'>
	</div>
	<div>
		<input type='password' name='password' value='admin'>
	</div>
	<div>
		<input type='submit'>
	</div>
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	
	</form>

</body>
</html>