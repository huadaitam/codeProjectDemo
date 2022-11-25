<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/jquery.rateyo.min.css">
<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/jquery.rateyo.min.js"></script>
<title>HongSam Book - Online Book Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2>Write a review</h2>
	</div>

	<div align="center">
		<form id="reviewForm" action="submit_review" method="post">
			<table class="book_none" width="80%">
				<tr>
					<td><h2>Your Review</h2></td>
					<td>&nbsp;</td>
					<td><h2>${checkCustomer.fullname}</h2></td>
				</tr>
				<tr>
					<td colspan="3"><hr /></td>
				</tr>
				<tr>
					<td rowspan="2"><span id="book_title">${book.title}</span><br />
						<img class="book-small_detail" alt="${book.title}"
						src="data:image/jpg;base64,${book.base64Image}"></td>
					<td>
						<div id="rateYo"></div> 
						<input type = "hidden" id="rating" name="rating" />	
						<input type = "hidden" name="bookId" value="${book.bookId}" />	
						<br />
						<input type="text" name="headline" size="60" placeholder="Headline or sumary for your review" /> 
						<br />
						<br /> 
						<textarea rows="10" cols="70" name="comment" placeholder="Write your review..."></textarea>
					</td>
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
			$("#reviewForm").validate({
				rules : {
					headline : "required",
					comment : "required"
				},

				messages : {
					headline :  "Please enter headline",
					comment : "Password is review detail"
				}
			});
			
			$("#buttonCancel").click(function() {
				 parent.history.back();
				 return false;
			});
			
		});
		
		$(function () {
			 
			  $("#rateYo").rateYo({
			    starWidth: "40px",
			    onSet: function(rating, rateYoInstance) {
			    	$("#rating").val(rating)
			    }
			  });
			 
			});
		
		
	</script>
</body>
</html>