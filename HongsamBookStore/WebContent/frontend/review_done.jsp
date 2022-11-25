<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>HongSam Book - Online Book Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2>Write a review</h2>
	</div>

	<div align="center">
		<form id="reviewForm" action="submit_review" method="post">
			<table class="book_none" width="60%">
				<tr>
					<td><h2>Review Post</h2></td>
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
					<td colspan = "2">
						<h3>Yours review has been posted!</h3>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<jsp:directive.include file="footer.jsp" />

</body>
</html>