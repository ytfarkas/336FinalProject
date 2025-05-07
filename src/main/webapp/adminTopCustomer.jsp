<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Customer</title>
</head>
<body>
<h2>Top Revenue-Generating Customer</h2>

<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

    String query = "SELECT Account_Number, SUM(Total_Cost) AS Revenue FROM Reservation GROUP BY Account_Number ORDER BY Revenue DESC LIMIT 1";

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(query);

    if (rs.next()) {
        String accNum = rs.getString("Account_Number");
        double revenue = rs.getDouble("Revenue");
        out.println("<p>Top Customer: " + accNum + " - $" + revenue + "</p>");
    } else {
        out.println("<p>No data available.</p>");
    }

    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>

<br><a href="adminHome.jsp">Back to Admin Dashboard</a>
</body>
</html>
