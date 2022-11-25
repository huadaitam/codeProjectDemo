<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>HongSam Book - Online Book Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<br />
		<h2>Welcome, ${checkCustomer.fullname}</h2>
		<br />
		<table class="book_none">
			<tr>
				<td><b>Email: </b></td>
				<td>${checkCustomer.email}</td>
			</tr>
			<tr>
				<td><b>Full Name:</b></td>
				<td>${checkCustomer.fullname}</td>
			</tr>
			<tr>
				<td><b>Phone Number:</b></td>
				<td>${checkCustomer.phone}</td>
			</tr>
			<tr>
				<td><b>Address:</b></td>
				<td>${checkCustomer.address}</td>
			</tr>
			<tr>
				<td><b>City:</b></td>
				<td>${checkCustomer.city}</td>
			</tr>
			<tr>
				<td><b>Zip Code:</b></td>
				<td>${checkCustomer.zipcode}</td>
			</tr>
			<tr>
				<td><b>Country:</b></td>
				<td>${checkCustomer.country}</td>
			</tr>
			<tr>
				<b>&nbsp;</b>
			</tr>
			<tr>
				<td colspan = "2" align="center"><a href="edit_profile" ><b>Edit My Profile</b></a></td>
			</tr>
		</table>
	</div>

	<jsp:directive.include file="footer.jsp" />
</body>
</html>