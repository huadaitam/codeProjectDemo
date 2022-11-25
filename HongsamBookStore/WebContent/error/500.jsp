<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Internal Server Error</title>
</head>
<body>
	<div align="center">
		<div >
			<img alt="logo" src="${pageContext.request.contextPath}/images/BookstoreLogo.svg">
		</div>
		
		<div>
			<h2>Sorry, the server has encountered an error while fulfilling your request.</h2>
			<h3>Please check back later or contact our administrator</h3>
		</div>
		<div>
			<a href="javascript:history.go(-1)">Go back</a>
		</div>
	</div>

</body>
</html>