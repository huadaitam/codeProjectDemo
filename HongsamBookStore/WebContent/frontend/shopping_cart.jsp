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
		<h2>Your Shopping Cart</h2>

		<c:if test="${message != null}">
			<div align="center">
				<h4 class="message">${message}</h4>
			</div>
		</c:if>

		<c:set var="cart" value="${sessionScope['cart']}"></c:set>

		<c:if test="${cart.totalItems == 0}">
			<h2>There's no items in your cart</h2>
		</c:if>

		<c:if test="${cart.totalItems > 0}">

			<form action="update_cart" method="post" id="cartFom">
				<div>
					<table border="1">
						<tr>
							<th>No</th>
							<th colspan="2">Book</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Subtotal</th>
							<th>Clear Cart</th>
						</tr>
						<c:forEach items="${cart.items}" var="item" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td><img class="book-small" alt="${book.title}" src="data:image/jpg;base64,${item.key.base64Image}"></td>
								<td valign="middle">${item.key.title}</td>
								<td>
									<input type="hidden" name="bookId" value="${item.key.bookId}" />
									<input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5">
								</td>
								<td>
									<fmt:setLocale value="en_US" /> 
									<fmt:formatNumber value="${item.key.price}" type="currency" />
								</td>
								<td>
									<fmt:setLocale value="en_US" /> 
									<fmt:formatNumber value="${item.value * item.key.price}" type="currency" />
								</td>
								<td><a href="remove_from_cart?book_id=${item.key.bookId}">Remove</a></td>
							</tr>
						</c:forEach>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td><b>${cart.totalQuantity} Book(s)</b></td>
							<td><b>Total: </b></td>
							<td colspan="2">
							<fmt:setLocale value="en_US" /> 
							<b><fmt:formatNumber value="${cart.totalAmount}" type="currency" /></b>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table class="book_none">
						<td></td>
						<td><button type="submit">Update</button></td>
						<td><input type="button" id="clearCart" value="Clear Cart" /></td>
						<td><a href="${pageContext.request.contextPath}/">Continue Shopping</a></td>
						<td><a href="checkout">Check out</a></td>
					</table>
				</div>
			</form>

		</c:if>


	</div>

	<jsp:directive.include file="footer.jsp" />

	<script type="text/javascript">
		$(document).ready(function() {
			$("#cartFom").validate({
				rules : {
					<c:forEach items="${cart.items}" var="item" varStatus="status">
						quantity${status.index + 1}: {
							required: true,
							number: true,
							min: 1
						},
					</c:forEach>
				},

				messages : {
					<c:forEach items="${cart.items}" var="item" varStatus="status">
						quantity${status.index + 1}: {
							required: "Please enter quantity",
							number: "Please enter number",
							min: "Quantity must be greater than 0"
						},
					</c:forEach>
				}
			});
			
			$("#clearCart").click(function() {
				window.location = 'clear_cart';
			})
		});
	</script>
</body>
</html>