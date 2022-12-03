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
<div class="text-c">
<h1 style="text-align:center;font-family: Futura;">Top 10 Best Sellers</h1>
<h3>Choose a list</h3>
<form method="get" action="bestBooks.jsp">
<select name="list" id="list">
	<option value="Hardcover_Fiction">Hardcover Fiction</option>
	<option value="Hardcover_Nonfiction">Hardcover Nonfiction</option>
	<option value="Manga">Manga</option>
	<option value="Animals">Animals</option>
	<option value="Culture">Culture</option>
	<option value="Education">Education</option>
	<option value="Health">Health</option>
	<option value="Science">Science</option>
</select>
</form>
</div>
<button onclick="getReviews()">Get list!</button>
<script>
function getReviews() {
	document.getElementById("output").innerHTML="";
	fetch("https://api.nytimes.com/svc/books/v3/lists/current/"+document.getElementById("list").value+".json?api-key=5WvZNOJRH5fLMuNpbGBYPSFHPCcwPaux").then(a=>a.json()).then(response=>{
	for(let i=0;i<10;i++){	document.getElementById("output").innerHTML+="<h2>"+response.results.books[i].rank+"</h2>"+"<h3>"+response.results.books[i].title+"</h3>"+response.results.books[i].author+"<br><img src='https://storage.googleapis.com/du-prd/books/images/"+response.results.books[i].primary_isbn13+".jpg'><br>"+response.results.books[i].description;}
	});
    
}
</script>


<br>
<div id="output"></div>
</body>
</html>

