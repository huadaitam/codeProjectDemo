<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="book_listnew">
		<div class="width_img">
			<a href="view_book?id=${book.bookId}"> <img class="book-small"
				alt="${book.title}" src="data:image/jpg;base64,${book.base64Image}">
			</a>
		</div>
		<div class="width_title">
			<a href="view_book?id=${book.bookId}"> <b>${book.title}</b>
			</a>
			<div>
				<jsp:directive.include file="book_rating.jsp" />
			</div>
			<div>
				by <i>${book.author}</i>
			</div>
			<div>
				<b>$ ${book.price}</b>
			</div>
		</div>

	</div>
</body>
</html>