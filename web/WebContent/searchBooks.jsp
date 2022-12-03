<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Search</title>
</head>
<body style="background-color:#FFFDD0">
<script>

function getBooks() {
	document.getElementById('output').innerHTML="";
	fetch("http://openlibrary.org/search.json?q="+document.getElementById("input").value).then(a=>a.json()).then(response=>{for (let i = 0; i <10; i++) {
    document.getElementById("output").innerHTML+="<h2>"+response.docs[i].title+"</h2>"+response.docs[i].author_name[0]+"<br><img src='http://covers.openlibrary.org/b/isbn/"+response.docs[i].isbn[0]+"-M.jpg'><br>";

		
	}});
}
</script>
<input id ="input">
<button onclick="getBooks()">Search Books!</button>
<br>
<div id="output"></div>
</body>
</html>

