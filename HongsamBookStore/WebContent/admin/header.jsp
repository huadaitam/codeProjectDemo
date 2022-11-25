<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<div align="center">
	<div>
		<a href="${pageContext.request.contextPath}/admin/">
			<img alt="logo" src="../images/BookstoreLogo.svg">
		</a>
	</div>
	<div>
		Welcome, <c:out value="${sessionScope.useremail}" /> | <a href="logout">Logout</a><br/><br/>
	</div>
	
	<div id="headermenu">
		<div>
			<a href="list_users">
				<img alt="users" src="../images/users.png"><br/>Users
			</a> 
		</div>
		
		<div>
			<a href="list_category">
				<img alt="category" src="../images/category.png"><br/>Categories
			</a> 
		</div>
		
		<div>
			<a href="list_books">
				<img alt="books" src="../images/bookstack.png"><br/>Books
			</a> 
		</div>
		
		<div>
			<a href="list_customer">
				<img alt="customer" src="../images/customer.png"><br/>Customer
			</a> 
		</div>
		
		<div>
			<a href="list_review">
				<img alt="reviews" src="../images/review.png"><br/>Reviews
			</a> 
		</div>
		
		<div>
			<a href="list_order">
				<img alt="orders" src="../images/order.png"><br/>Orders
			</a> 
		</div>
				
	</div>
</div>