<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<title>HongSam Book - Online Book Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2 class="pageheading">Your Orders</h2>
	</div>

	<c:if test="${order == null}">
		<div align="center">
			<h2>Sorry, you don't have this order!</h2>
		</div>
	</c:if>
	
	<c:if test="${order != null}">
		<div align="center">
			<h2>Order Overview:</h2>
			<table>
				<tr>
					<td><b>Order Status:</b></td>
					<td>${order.status}</td>
				</tr>
				<tr>
					<td><b>Order Date:</b></td>
					<td>${order.orderDate}</td>
				</tr>
				<tr>
					<td><b>Quantity:</b></td>
					<td>${order.bookCopies}</td>
				</tr>
				<tr>
					<td><b>Total Amount:</b></td>
					<td>
						<fmt:setLocale value="en_US" /> 
						<fmt:formatNumber value="${order.total}" type="currency" />
					</td>
				</tr>
				<tr>
					<td><b>Recipient Name:</b></td>
					<td>${order.recipientName}</td>
				</tr>
				<tr>
					<td><b>Recipient Phone:</b></td>
					<td>${order.recipientPhone}</td>
				</tr>
				<tr>
					<td><b>Shipping Address:</b></td>
					<td>${order.shippingAddress}</td>
				</tr>
				<tr>
					<td><b>Payment Method:</b></td>
					<td>${order.paymentMethod}</td>
				</tr>
			</table>
		</div>
		<div align="center">
			<h2>Ordered Books</h2>
			 <table border="1">
			 	<tr>
			 		<th><b>No</b></th>
			 		<th><b>Book</b></th>
			 		<th><b>Author</b></th>
			 		<th><b>Price</b></th>
			 		<th><b>Quantity</b></th>
			 		<th><b>Subtotal</b></th>
			 	</tr>
			 	<c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
			 		<tr>
			 			<td>${status.index + 1}</td>
			 			<td>
				 			<img alt="image-book" src="data:image/jpg;base64,${orderDetail.book.base64Image}" width="48" height="64" />
				 			${orderDetail.book.title}
			 			</td>
			 			<td>${orderDetail.book.author}</td>
			 			<td>
				 			<fmt:setLocale value="en_US" /> 
							<fmt:formatNumber value="${orderDetail.book.price}" type="currency" />
			 			</td>
			 			<td>${orderDetail.quantity}</td>
			 			<td>
			 				<fmt:setLocale value="en_US" /> 
							<fmt:formatNumber value="${orderDetail.subtotal}" type="currency" />
			 			</td>
			 		</tr>
			 	</c:forEach>
			 	<tr>
			 		<td colspan="4" align="right">
			 			<b>TOTAL:</b>
			 		</td>
			 		<td><b>${order.bookCopies}</b></td>
			 		<td>
			 			<b>
				 			<fmt:setLocale value="en_US" /> 
							<fmt:formatNumber value="${order.total}" type="currency" />
						</b>
			 		</td>
			 	</tr>
			 </table>
		</div>
	</c:if>
	<jsp:directive.include file="footer.jsp" />
</body>
</html>