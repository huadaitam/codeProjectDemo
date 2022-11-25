<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create New Customer</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2 class="pageheading">
			<c:if test="${book != null}">
				Edit Customer
			</c:if>
			<c:if test="${book == null}">
				Create New Customer
			</c:if>
		</h2>
	</div>

	<div align="center">
		<c:if test="${customer != null}">
			<form action="update_customer" method="post" id="customerForm">
				<input type="hidden" name="customerId" value="${customer.customerId}">
		</c:if>
		<c:if test="${customer == null}">
			<form action="create_customer" method="post" id="customerForm">
		</c:if>
		<table class="form">
			<tr>
				<td>Email:</td>
				<td><input type="text" id="email" name="email" size="45"
					value="${customer.email}" /></td>
			</tr>
			<tr>
				<td>Full Name:</td>
				<td><input type="text" id="fullName" name="fullName" size="45"
					value="${customer.fullname}" /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" id="password" name="password" size="45"
					value="${customer.password}" /></td>
			</tr>
			<tr>
				<td>Confirm Password:</td>
				<td><input type="password" id="confirmPassword" name="confirmPassword" size="45"
					value="${customer.password}" /></td>
			</tr>
			<tr>
				<td>Phone Number:</td>
				<td><input type="text" id="phone" name="phone" size="45"
					value="${customer.phone}" /></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><input type="text" id="address" name="address" size="45"
					value="${customer.address}" /></td>
			</tr>
			<tr>
				<td>City:</td>
				<td><input type="text" id="city" name="city" size="45"
					value="${customer.city}" /></td>
			</tr>
			<tr>
				<td>ZipCode:</td>
				<td><input type="text" id="zipcode" name="zipcode" size="45"
					value="${customer.zipcode}" /></td>
			</tr>
			<tr>
				<td>Country:</td>
				<td><input type="text" id="country" name="country" size="45"
					value="${customer.country}" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">Save</button>&nbsp;&nbsp;&nbsp;
					<button id="buttonCancel">Cancel</button>
				</td>
			</tr>
		</table>
		</form>
	</div>

	<jsp:directive.include file="footer.jsp" />


	<script type="text/javascript">

	$(document).ready(function() {
		$("#customerForm").validate({
			rules: {
				email: {
					required: true,
					email: true
				},
				fullName: "required",
				password: "required",
				confirmPassword: {
					required: true,
					equalTo: "#password"
				},
				phone: "required",
				address: "required",
				city: "required",
				zipcode: "required",
				country: "required"
			},
			
			messages: {
				email: {
					required: "Please enter email address",
					email: "Please enter a valid email address"
				},
				fullName: "Please enter fullname",
				password: "Please enter password",
				confirmPassword: {
					required: "Please confirm password",
					equalTo: "Confirm password does not math password"
				},
				phone: "Please enter phone number",
				address: "Please enter address",
				city: "Please enter fullname city",
				zipcode: "Please enter fullname zip code",
				country: "Please enter fullname country"
				
			}
		});
		
		$("#buttonCancel").click(function() {
			 parent.history.back();
			 return false;
		})
	});
	
</script>
</body>
</html>