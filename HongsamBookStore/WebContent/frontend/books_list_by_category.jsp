<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Book in ${category.name} - Online Book Store</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div class="center">
		<h1>${category.name}</h1>
	</div>

	<div class="book_group">
		<c:forEach items="${listBooks}" var="book">
			<div style="float: left; display: inline-block; margin: 10px;">
				<div>
					<a href="view_book?id=${book.bookId}"> <img class="book-small"
						alt="${book.title}"
						src="data:image/jpg;base64,${book.base64Image}">
					</a>
				</div>
				<div>
					<a href="view_book?id=${book.bookId}"> <b>${book.title}</b>
					</a>
					<div>
						<c:forTokens items="${book.ratingStars}" delims="," var="star">
							<c:if test="${star eq 'on'}">
								<img src="images/rating_on.png" />
							</c:if>
							<c:if test="${star eq 'off'}">
								<img src="images/rating_off.png" />
							</c:if>
							<c:if test="${star eq 'half'}">
								<img src="images/rating_half.png" />
							</c:if>
						</c:forTokens>
					</div>
					<div>
						by <i>${book.author}</i>
					</div>
					<div>$ ${book.price}</div>
				</div>

			</div>
		</c:forEach>
	</div>

	<jsp:directive.include file="footer.jsp" />
</body>
</html>