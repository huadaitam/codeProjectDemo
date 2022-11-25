<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/style.css">
<title>HongSam Bookstore Administration</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
			<h2 class="pageheading">Administration Dashboard</h2>
	</div>
	
	<div align="center">
		<hr width="60%" />
		<h2 class="pageheading">Quick Actions:</h2>
		<b>
			<a href="book_form.jsp">New Book</a> &nbsp;
			<a href="user_form.jsp">New User</a> &nbsp;
			<a href="category_form.jsp">New Category</a> &nbsp;
			<a href="customer_form.jsp">New Customer</a> 
		</b>
	</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="pageheading">Best-Selling Books</h2>
		<table border="1">
			<tr>
				<th>OrderId</th>
				<th>Order By</th>
				<th>Book Copies</th>
				<th>ToTal</th>
				<th>Payment Method</th>
				<th>Status</th>
				<th>Order Data</th>
			</tr>
			<c:forEach items="${listMostRecentSales}" var="order" varStatus="status">
				<tr>
					<td><a href="view_order?id=${order.orderId}">${order.orderId}</a></td>
					<td>${order.customer.fullname}</td>
					<td>${order.bookCopies}</td>
					<td>
						<fmt:setLocale value="en_US" /> 
						<fmt:formatNumber value="${order.total}" type="currency" />
					</td>
					<td>${order.paymentMethod}</td>
					<td>${order.status}</td>
					<td>${order.orderDate}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="pageheading">Most-favored Books</h2>
		<table border="1">
			<tr>
				<th>Book</th>
				<th>Rating</th>
				<th>Headline</th>
				<th>Customer</th>
				<th>Review On</th>
			</tr>
			<c:forEach items="${listMostRecent}" var="review" varStatus="status">
				<tr>
					<td>${review.book.title}</td>
					<td>${review.rating}</td>
					<td><a href="edit_review?id=${review.reviewId}">${review.headline}</a></td>
					<td>${review.customer.fullname}</td>
					<td>${review.reviewTime}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="pageheading">Static</h2>
		Total Users: ${totalUsers} &nbsp;&nbsp;&nbsp;&nbsp;
		Total Books: ${totalBooks} &nbsp;&nbsp;&nbsp;&nbsp;
		Total Customers: ${totalCustomers} &nbsp;&nbsp;&nbsp;&nbsp;
		Total Reviews: ${totalReviews} &nbsp;&nbsp;&nbsp;&nbsp;
		Total Orders: ${totalOrders} 
		<hr width="60%" />
	</div>
	
	<jsp:directive.include file="footer.jsp" />
</body>
</html>