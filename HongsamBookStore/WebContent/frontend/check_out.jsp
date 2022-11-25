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
				<div>
					<h2>Review your order detail <a href="">Edit</a></h2>
					<table border="1">
						<tr>
							<th>No</th>
							<th colspan="2">Book</th>
							<th>Author</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Subtotal</th>
						</tr>
						<c:forEach items="${cart.items}" var="item" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td><img class="book-small" alt="${book.title}" src="data:image/jpg;base64,${item.key.base64Image}"></td>
								<td valign="middle">${item.key.title}</td>
								<td valign="middle">${item.key.author}</td>
								<td>
									<fmt:setLocale value="en_US" /> 
									<fmt:formatNumber value="${item.key.price}" type="currency" />
								</td>
								<td>
									<input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5" readonly="readonly">
								</td>
								<td>
									<fmt:setLocale value="en_US" /> 
									<fmt:formatNumber value="${item.value * item.key.price}" type="currency" />
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="5" align="right"><b>Total: </b></td>
							<td><b>${cart.totalQuantity} Book(s)</b></td>
							<td>
							<fmt:setLocale value="en_US" /> 
							<b><fmt:formatNumber value="${cart.totalAmount}" type="currency" /></b>
							</td>
						</tr>
					</table>
					<h2>Your shipping information</h2>
					<form id="orderForm" action="place_order" method="post">
						<table>
							<tr>
								<td>Recipient name:</td>
								<td><input type="text" name="recipientName" value="${checkCustomer.fullname}"></td>
							</tr>
							<tr>
								<td>Recipient Phone:</td>
								<td><input type="text" name="recipientPhone"  value="${checkCustomer.phone}"></td>
							</tr>
							<tr>
								<td>Street address:</td>
								<td><input type="text" name="address"  value="${checkCustomer.address}"></td>
							</tr>
							<tr>
								<td>City:</td>
								<td><input type="text" name="city"  value="${checkCustomer.city}"></td>
							</tr>
							<tr>
								<td>Zip code:</td>
								<td><input type="text" name="zipcode"  value="${checkCustomer.zipcode}"></td>
							</tr>
							<tr>
								<td>Country:</td>
								<td><input type="text" name="country"  value="${checkCustomer.country}"></td>
							</tr>
						</table>
						<div>
							<h2>Payment</h2>
							Choose your payment method:
							&nbsp;&nbsp;&nbsp;&nbsp;
							<select name="paymentMethod">
								<option value="Cash On Delivery">Cash On Delivery</option>
							</select>							
						</div>
						<div>
							<table class="book_none">
								<td></td>
								<td><button type="submit">Place Order</button></td>
								<td><a href="${pageContext.request.contextPath}/">Continue Shopping</a></td>
							</table>
						</div>
					</form>
				</div>
		</c:if>


	</div>

	<jsp:directive.include file="footer.jsp" />

	<script type="text/javascript">
		$(document).ready(function() {
			$("#orderForm").validate({
				rules: {
					recipientName: "required",
					recipientPhone: "required",
					address: "required",
					city: "required",
					zipcode: "required",
					county: "required"
				},
				
				messages: {
					recipientName: "Please enter recipient Name",
					recipientPhone: "Please enter recipient Phone",
					address: "Please enter adress",
					city: "Please enter city",
					zipcode: "Please enter zipcode",
					county: "Please enter county"
				}
			});
		});
	</script>
</body>
</html>