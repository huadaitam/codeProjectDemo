<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HongSam Book - Online Book Store</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">

		<c:if test="${fn:length(result) == 0}">
			<h2>No Results for "${keyword}"</h2>
		</c:if>

		<c:if test="${fn:length(result) > 0}">
			<div class="book_group">
				<center>
					<h2>Results for "${keyword}":</h2>
				</center>
				<div class="forEach">
					<c:forEach items="${result}" var="book">
						<div>
							<div id="search_img">
								<div>
									<a href="view_book?id=${book.bookId}"> <img
										class="book-small" alt="${book.title}"
										src="data:image/jpg;base64,${book.base64Image}">
									</a>
								</div>
							</div>
							<div id="search_info">
								<div>
									<h2>
										<a href="view_book?id=${book.bookId}"><b>${book.title}</b></a>
									</h2>
								</div>
								<div>
									<jsp:directive.include file="book_rating.jsp" />
								</div>
								<div>
									by <i>${book.author}</i>
								</div>
								<div>
									<p>${fn:substring(book.description, 0, 100)}...</p>
								</div>
							</div>
							<div id="search_price">
								<h3>
									<b>$ ${book.price}</b>
								</h3>
								<h3><a href="add_to_cart?book_id=${book.bookId}">Add To Cart</a></h3>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</div>

	<jsp:directive.include file="footer.jsp" />
</body>
</html>