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
		<h2 class="pageheading">Edit Order ID: ${order.orderId}</h2>
	</div>

	<div align="center">
		<h4 class="message">${message}</h4>
	</div>s

	<form  id="orderForm" action="update_order" method="post">
		<div align="center">
			<h2>Order Overview:</h2>
			<table>
				<tr>
					<td><b>Ordered By:</b></td>
					<td>${order.customer.fullname}</td>
				</tr>
				<tr>
					<td><b>Order Date:</b></td>
					<td>${order.orderDate}</td>
				</tr>
				<tr>
					<td><b>Recipient Name:</b></td>
					<td><input type="text" name="recipientName" value="${order.recipientName}" size="45" /></td>
				</tr>
				<tr>
					<td><b>Recipient Phone:</b></td>
					<td><input type="text" name="recipientPhone" value="${order.recipientPhone}" size="45" /></td>
				</tr>
				<tr>
					<td><b>Ship to:</b></td>
					<td><input type="text" name="shippingAddress" value="${order.shippingAddress}" size="45" /></td>
				</tr>
				<tr>
					<td><b>Payment Method:</b></td>
					<td>
						<select name="paymentMethod">
							<option value="Cash On Delivery">Cash On Delivery</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><b>Order Status:</b></td>
					<td>
						<select name="orderStatus">
							<option value="Processing">Processing</option>
							<option value="Shipping">Shipping</option>
							<option value="Delivered">Delivered</option>
							<option value="Completed">Completed</option>
							<option value="Cancelled">Cancelled</option>
						</select>
					</td>
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
			 		<th></th>
			 	</tr>
			 	<c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
			 		<tr>
			 			<td>${status.index + 1}</td>
			 			<td>${orderDetail.book.title}</td>
			 			<td>${orderDetail.book.author}</td>
			 			<td>
			 				<input type="hidden" name="price" value="${orderDetail.book.price}" />
				 			<fmt:setLocale value="en_US" /> 
							<fmt:formatNumber value="${orderDetail.book.price}" type="currency" />
			 			</td>
			 			<td>
			 				<input type="hidden" name="bookId" value="${orderDetail.book.bookId}" />
			 				<input type="text" name="quantity${status.index + 1}" value="${orderDetail.quantity}" size="5" />
			 			</td>
			 			<td>
			 				<fmt:setLocale value="en_US" /> 
							<fmt:formatNumber value="${orderDetail.subtotal}" type="currency" />
			 			</td>
			 			<td><a href="remove_book_form_order?id=${orderDetail.book.bookId}">Remove</a></td>
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
			<a href="javascript:showAddBookPopup()" ><b>Add Books</b></a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value="Save" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="buttonCancel" value="Cancel" />
		</div>
	</form>
	<jsp:directive.include file="footer.jsp" />

<script type="text/javascript">
	$(document).ready(function () {
		$("#orderForm").validate({
			rules: {
				recipientName: "required",
				recipientPhone: "required",
				shippingAddress: "required",

				<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
					quantity${status.index + 1}: {
						required: true,
						number: true,
						min: 1
					},
				</c:forEach>
			},
			
			messages: {
				recipientName: "Please enter recipient Name",
				recipientPhone: "Please enter recipient Phone",
				shippingAddress: "Please enter Address",

				<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
					quantity${status.index + 1}: {
						required: "Please enter quantity",
						number: "Please enter number",
						min: "Quantity must be greater than 0"
					},
				</c:forEach>
			}
		});
		
		$("#buttonCancel").click(function() {
			 window.location.href='list_order';
		})
	});

	function showAddBookPopup() {
		const width = 800;
		const height = 250;
		const left = (screen.width - width) / 2;
		const top = (screen.height - height) /2;
		window.open('add_book_form', '_blank', 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left)
	}

	
	
</script>
</body>
</html>