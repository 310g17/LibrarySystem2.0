<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Review</title>
</head>
<body style="background-color:#FFFDD0">
<script>

function getReviews() {
	
	document.getElementById("output").innerHTML="";
	fetch("https://api.nytimes.com/svc/books/v3/reviews.json?title="+document.getElementById("input").value+"&api-key=5WvZNOJRH5fLMuNpbGBYPSFHPCcwPaux").then(a=>a.json()).then(response=>{
		document.getElementById("output").innerHTML="<h2>"+response.results[0].book_title+"</h2>"+response.results[0].book_author+"<h3>"+response.results[0].summary+"</h3>";
	});
    
}
</script>


<h3>Enter the name of the book you want to review</h3>
<input id ="input">
<button onclick="getReviews()">Get book summary!</button>
<br>
<div id="output"></div>
</body>
</html>

