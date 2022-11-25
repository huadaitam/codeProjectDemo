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
<title>Manage Reviews - HongSam Bookstore Administration</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
			<h2 class="pageheading">Review Management</h2>
	</div>
	
	<div align="center">
		<h4 class="message">${message}</h4>
	</div>

	
	<div align="center">
		<table border="1">
			<tr>
				<th>Index</th>
				<th>ID</th>
				<th>Book</th>
				<th>Rating</th>
				<th>Headline</th>
				<th>Customer</th>
				<th>Review On</th>
				<th>Actions</th>
			</tr>
			<c:forEach var="review" items="${listReviews}" varStatus="status" >
				<tr>
					<td>${status.index + 1}</td>
					<td>${review.reviewId}</td>
					<td>${review.book.title}</td>
					<td>${review.rating}</td>
					<td>${review.headline}</td>
					<td>${review.customer.fullname}</td>
					<td>${review.reviewTime}</td>
					<td>
						<a href="edit_review?id=${review.reviewId}">Edit</a> &nbsp;
						<a href="javascript:void(0)" class="deleteLink" id="${review.reviewId}">Delete</a> &nbsp;
					</td>
				</tr>
			</c:forEach>			
		</table>
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
<script type="text/javascript">
	$(document).ready(function () {
		$(".deleteLink").each(function() {
			$(this).on("click", function() {
				reviewId = $(this).attr("id");
				if(confirm('Are you sure you want to delete the category with ID ' + reviewId + '?')) {
					window.location = 'delete_review?id=' + reviewId;
				}
			})
		})
	});
</script>
</body>
</html>