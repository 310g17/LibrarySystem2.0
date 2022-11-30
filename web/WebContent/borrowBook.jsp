<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.time.LocalDate"%> 
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import="java.util.concurrent.TimeUnit"%> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Success</title>
</head>
<body style="background-color:#FFFDD0;">

<div class="text-c">
<style>
    .text-c {
		text-align: center;
	}
</style>
<%

String bookName = request.getParameter("bookName");
if(bookName == null) {
	bookName = "";
}
String username = request.getParameter("uname");
if(username == null) {
	username = "";
}


//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = DriverManager.getConnection(url, uid, pw);


String sql = "SELECT uid, uname, book1, book2, date1, date2 FROM users";
String sql2 = "";
Statement stmt = con.createStatement();

Date date = Date.valueOf(LocalDate.now());

ResultSet rst = stmt.executeQuery(sql);

while(rst.next()){
    if(rst.getString("uname").equals(username)){
        if(rst.getString("book1")==null){
            sql2 = "UPDATE users SET book1=?, date1=? WHERE uname=?";
            PreparedStatement pstmt = con.prepareStatement(sql2);
            pstmt.setString(1, bookName);
            pstmt.setDate(2, date);
            pstmt.setString(3, username);
            pstmt.executeUpdate();
            %>
                <h2>You successfully borrowed a book</h2>
			    <%
        } else if(rst.getString("book2")==null){
            Date dateDika = rst.getDate("date1");
            long diff = date.getTime() - dateDika.getTime();
            if(TimeUnit.DAYS.convert(diff,TimeUnit.MILLISECONDS)<14){
                sql2 = "UPDATE users SET book2=?, date2=? WHERE uname=?";
                PreparedStatement pstmt = con.prepareStatement(sql2);
                pstmt.setString(1, bookName);
                pstmt.setDate(2, date);
                pstmt.setString(3, username);
                pstmt.executeUpdate();
                %>
                <h2>You successfully borrowed a book</h2>
			    <%
            }else{
                %>
                <h2>You cannot borrow a book if you are late to return your previous book</h2>
			    <%
            }
            
        } else{
            %>
                <h2>You already borrowed 2 books, you cannot borrow more</h2>
			    <%
        }
    }
}


con.close();

%>

<form method="get" action="ShowStatus.jsp">
    <input type="submit" value="Show Status">
    <input type="hidden" name="un" value=<%=username%>> 
    <input type="hidden" name="bn" value=<%=bookName%>> 
</form>

</div>
<div id="google_translate_element"></div>
<script type="text/javascript">
    function googleTranslateElementInit() {
      new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
    }
    </script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
</body>
</html>