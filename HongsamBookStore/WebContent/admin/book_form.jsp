<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create New User</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/richtext.min.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../css/jquery-ui.min.css">
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../js/jquery.richtext.js"></script>
<script type="text/javascript" src="../js/jquery.richtext.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2 class="pageheading">
			<c:if test="${book != null}">
				Edit Book
			</c:if>
			<c:if test="${book == null}">
				Create New Book
			</c:if>
		</h2>
	</div>

	<div align="center">
		<c:if test="${book != null}">
			<form action="update_book" method="post" id="bookForm"
				enctype="multipart/form-data">
				<input type="hidden" name="bookId" value="${book.bookId}">
		</c:if>
		<c:if test="${book == null}">
			<form action="create_book" method="post" id="bookForm"
				enctype="multipart/form-data">
		</c:if>
		<table class="form">
			<tr>
				<td>Category:</td>
				<td><select name="category">
						<c:forEach items="${listCategory}" var="category">
							<c:if test="${category.categoryId eq book.category.categoryId}">
								<option value="${category.categoryId}" selected>
								</c:if>
								
								<c:if test="${category.categoryId ne book.category.categoryId}">
									<option value="${category.categoryId}">
								</c:if>
									${category.name}
								</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>Title:</td>
				<td><input type="text" id="title" name="title" size="20"
					value="${book.title}" /></td>
			</tr>
			<tr>
				<td>Author:</td>
				<td><input type="text" id="author" name="author" size="20"
					value="${book.author}" /></td>
			</tr>
			<tr>
				<td>ISBN:</td>
				<td><input type="text" id="isbn" name="isbn" size="20"
					value="${book.isbn}" /></td>
			</tr>
			<tr>
				<td>Publish Date:</td>
				<td><input type="text" id="publishDate" name="publishDate"
					size="20"
					value='<fmt:formatDate pattern="MM/dd/yyy" value="${book.publishDate}"/>' /></td>
			</tr>
			<tr>
				<td>Book Image:</td>
				<td><input type="file" id="bookImage" name="bookImage"
					size="20" /><br /> <img id="thumbnail" alt="Image preview"
					style="width: 20%; margin-top: 10px;"
					src="data:image/jpg;base64,${book.base64Image}" /></td>
			</tr>
			<tr>
				<td>Price:</td>
				<td><input type="text" id="price" name="price" size="20"
					value="${book.price}" /></td>
			</tr>
			<tr>
				<td>Description:</td>
				<td><textarea rows="5" cols="50" name="description"
						class="content" id="description">${book.description}</textarea></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
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
		
		$("#publishDate").datepicker();
		$('.content').richText();

		
		$("#bookImage").change(function() {
			showImageThumbnail(this);
		})
		
		$("#bookForm").validate({
			rules: {
				category: "required",
				title: "required",
				author: "required",
				isbn: "required",
				publishDate: "required",
				
				<c:if test="${book = null}">
				bookImage: "required",
				</c:if>
				
				price: "required",
				description: "required"
			},
			
			messages: {
				category: "Category is not selected",
				title: "Title is required",
				author: "Author is required",
				isbn: "ISBN is required",
				bookImage: "Book image is required",
				price: "Price is required",
				description: "Desciption is required"
				
			}
		});
		
		$("#buttonCancel").click(function() {
			 parent.history.back();
			 return false;
		})
	});
	
	function showImageThumbnail(fileInput) {
		const file = fileInput.files[0];
		
		const reader = new FileReader();
		reader.onload = function(e) {
			$("#thumbnail").attr("src", e.target.result);
		}
		
		reader.readAsDataURL(file);
	}
</script>
</body>
</html>