<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
</head>
<body>
	<table>
			<tr>
				<td>id</td>
				<td>lastName</td>
				<td>gender</td>
				<td>email</td>
			</tr>
		<c:forEach items="${emps}" var="emp">
			<tr>
				<td>${emp.id }</td>
				<td>${emp.lastName }</td>
				<td>${emp.gender }</td>
				<td>${emp.email }</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>