<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>Summary of Books</title>
</head>
<body style="background-color:#FFFDD0">
    <div class="text-c">
    <form method="get" action="summaryResult.jsp">
        <h3>Write your book name here: </h3>
        <input type="text" name="bookName" size="30">
        <input type="submit" value="Submit"><input type="reset" value="Reset">
        </form>
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
<%

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = DriverManager.getConnection(url, uid, pw);
// Print out the order summary information



%>
<h2 style="text-align:center;font-family: Futura;">books</h2>
		<table border="1" style="margin-left:auto;margin-right:auto;font-family: Futura;">
				<tr>
					<th>ISBN</th>
					<th>Book Name</th>
					<th>Author</th>
					<th>Year Published</th>
					<th>Genre</th>
					<th>Quantity</th>
					<th>Total Amount</th>
				</tr>
<div class="form_pos text-c">
<%
String sql = "SELECT * FROM books WHERE qty>0";
PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
    while(rst.next()) {
        %><tr>
            <td style="text-align:center;font-family: Futura;"><%=rst.getInt("isbn")%></td>
            <td style="text-align:center;font-family: Futura;"><%=rst.getString("bookName")%></td>
            <td style="text-align:center;font-family: Futura;"><%=rst.getString("author")%></td>
            <td style="text-align:center;font-family: Futura;"><%=rst.getInt("yearPub")%></td>
            <td style="text-align:center;font-family: Futura;"><%=rst.getString("genre")%></td>
            <td style="text-align:center;font-family: Futura;"><%=rst.getInt("qty")%></td>
            <td style="text-align:center;font-family: Futura;"><%=rst.getInt("originalAmt")%></td>
        </tr>
        <%
    }
        %>
		
</form>
<div id="google_translate_element"></div>
</div>

<script type="text/javascript">
	function googleTranslateElementInit() {
	  new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
	}
	</script>
	
	<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
</body>
</html>

