<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<title>Admin Login</title>
</head>
<body>
	<div align="center">
		<h1>Book Store Administration</h1>
		<h2>Admin Login</h2>
		
		<c:if test="${message != null}">
			<div align="center">
			<h4 class="message">${message}</h4>
			</div>
		</c:if>
		
		<form id="formLogin" action="login" method="post">
			<table>
				<tr>
					<td>Email:</td>
					<td>
						<input type="text" name="email" id="email" size="20" />
					</td>
				</tr>
				
				<tr>
					<td>Password:</td>
					<td>
						<input type="password" name="password" id="password" size="20" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">Login</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
<script type="text/javascript">

	$(document).ready(function() {
		$("#formLogin").validate({
			rules: {
				email: {
					required: true,
					email: true
				},
				password: "required"
			},
			
			messages: {
				email: {
					required: "Email is required",
					email: "Please enter an valid email address"
				},
				password: "Password is required"
			}
		});
	});
</script>	
</body>
</html>