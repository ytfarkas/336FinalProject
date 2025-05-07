<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
</head>
<body>
<h2>Sales Report (Enter Month)</h2>

<form method="get">
    Month (YYYY-MM): <input type="text" name="month">
    <input type="submit" value="Get Report">
</form>

<%
String month = request.getParameter("month");
if (month != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

        String query = "SELECT SUM(Total_Fair) AS Total_Sales FROM Ticket WHERE DATE_FORMAT(Purchase_Date, '%m') LIKE ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, month + "%");
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            double totalSales = rs.getDouble("Total_Sales");
            out.println("<h3>Total Sales for " + month + ": $" + totalSales + "</h3>");
        } else {
            out.println("<p>No sales for that month.</p>");
        }

        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>

<br><a href="adminHome.jsp">Back to Admin Dashboard</a>
</body>
</html>
