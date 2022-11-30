<%@ page import="org.jsoup.*" %>
<%@ page import ="java.net.URLEncoder" %>
<%@ page import = "java.io.BufferedReader" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.util.*" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.jsoup.nodes.Element" %>
<!DOCTYPE html>
<html>
<head>
<title>Summary of Books</title>
</head>
<body style="background-color:#FFFDD0">
    <div class="text-c">
    <form method="get" action="summaryResult.jsp">
        
    </div>
<br>
<style>
    .text-c {
		text-align: center;
	}
	
	.form_pos { 
		position:relative;
		left:0;
		right:0;
		bottom:0;
		margin-left:auto;
		margin-right:auto;
	}
</style>
<div class="text-c">
<%


try{
	
	//PARSE your STRING
	String bookName = request.getParameter("bookName");
	%>

	<h1><%out.println("This is a wikipedia summary of the first 2 paragraphs of " + bookName);%></h1>
	<br>
	<%
	String url = "http://en.wikipedia.org/wiki/";
	Scanner scan = new Scanner(System.in);
	String pp = bookName;
	pp = pp.replace(' ', '_');
	url +=pp;
	out.println("The full article can be found on: " + url);
	
	%>
	<br>
	<%
	//CONNECT TO WIKIPEDIA
	Document doc = Jsoup.connect(url).get();
	//GET THE DATA
	Elements paragraphs = doc.select(".mw-content-ltr p");

	//print first 2 lines two prevent over explaining books
	Element firstParagraph = paragraphs.first();
	Element lastParagraph = paragraphs.last();
	Element p;
	int i=1;
	int x = 2;
	p=firstParagraph;
	//first two paragraphs
	while (p!=lastParagraph && i <= x){
		p=paragraphs.get(i);
	   out.println(p.text() + "\n");
		i++;}
}catch(Exception e){
	out.println("No wiki found, check for spelling errors or case sensitive words");
}

%>

<br>
<h3><a href="listBook.jsp">Click here to return to borrow book</a></h3>
</div>
</div>
</body>
</html>

