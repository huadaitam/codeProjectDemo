<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HongSam Book - Online Book Store</title>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
</head>
<body>
	<div align="center">
		<h2>The Book <i>${book.title}</i> has been add to the order ID ${order.orderId}</h2>
		<input type="button" id="buttonCancel" value="Close">
	</div>
<script type="text/javascript">
	window.onunload = function(){ 
		  window.opener.location.reload(); 
	}; 
	
	$(document).ready(function () {
		$("#buttonCancel").click(function() {
			window.close();
		})
	});
</script>
</body>
</html>