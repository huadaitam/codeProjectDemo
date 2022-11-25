<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<title>Manage Orders - HongSam Bookstore Administration</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2 class="pageheading">Details Of Order ID: ${order.orderId}</h2>
	</div>

	<div align="center">
		<h4 class="message">${message}</h4>
	</div>


	<div align="center">
		<h2>Order Overview:</h2>
		<table>
			<tr>
				<td><b>Ordered By:</b></td>
				<td>${order.customer.fullname}</td>
			</tr>
			<tr>
				<td><b>Book Copies:</b></td>
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
				<td><b>Payment Method:</b></td>
				<td>${order.paymentMethod}</td>
			</tr>
			<tr>
				<td><b>Shipping Address:</b></td>
				<td>${order.shippingAddress}</td>
			</tr>
			<tr>
				<td><b>Order Status:</b></td>
				<td>${order.status}</td>
			</tr>
			<tr>
				<td><b>Order Date:</b></td>
				<td>${order.orderDate}</td>
			</tr>
		</table>
	</div>
	<div align="center">
		<h2>Ordered Books</h2>
		 <table border="1">
		 	<tr>
		 		<th><b>Index</b></th>
		 		<th><b>Book Title</b></th>
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
	<div align="center">
		<br/>
		<a href="edit_order?id=${order.orderId}">Edit this oder</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0)" class="deleteLink" id="${order.orderId}">Delete</a>
	</div>
	
	<jsp:directive.include file="footer.jsp" />

<script type="text/javascript">
	$(document).ready(function () {
		$(".deleteLink").each(function() {
			$(this).on("click", function() {
				orderId = $(this).attr("id");
				if(confirm('Are you sure you want to delete the category with ID ' + orderId + '?')) {
					window.location = 'delete_order?id=' + orderId;
				}
			})
		})
	});
</script>
</body>
</html>