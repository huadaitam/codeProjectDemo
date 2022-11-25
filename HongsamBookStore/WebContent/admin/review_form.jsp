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
<title>Create New Category</title>
</head>
<body>
<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2 class="pageheading">Edit Review</h2>
	</div>
	
	<div align="center">
		<form action="update_review" method="post" id="reviewForm">
		<input type="hidden" name="reviewId" value="${review.reviewId}" />
		
			<table class="form">
				<tr>
					<td>Book:</td>
					<td><b>${review.book.title}</b></td>
				</tr>
				<tr>
					<td>Rating:</td>
					<td><b>${review.rating}</b></td>
				</tr>
				<tr>
					<td>Customer:</td>
					<td><b>${review.customer.fullname}</b></td>
				</tr>
				<tr>
					<td>Headline:</td>
					<td><input type = "text" size = "60" name = "headline" value = "${review.headline}"></td>
				</tr>
				<tr>
					<td>Comment:</td>
					<td>
						<textarea rows="5" cols="70" name="comment">${review.comment}</textarea>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
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
		$("#reviewForm").validate({
			rules: {
				headline: "required",
				comment: "required"
			},
			
			messages: {
				headline: "Headline is required",
				comment: "Comment is required"
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