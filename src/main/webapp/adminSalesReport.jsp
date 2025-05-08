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

<form action="adminSalesReport.jsp" method="POST">
    <label for="month">Choose a month:</label>
    <select name="month" id="month">
        <option value="01">January</option>
        <option value="02">February</option>
        <option value="03">March</option>
        <option value="04">April</option>
        <option value="05">May</option>
        <option value="06">June</option>
        <option value="07">July</option>
        <option value="08">August</option>
        <option value="09">September</option>
        <option value="10">October</option>
        <option value="11">November</option>
        <option value="12">December</option>
    </select><br><br>
    <input type="submit" value="Generate Report">
</form>

<%
    String month = request.getParameter("month");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject?useSSL=false&serverTimezone=UTC", "root", "mysqlpassword");

        String query = "SELECT MONTH(Departure_Date), SUM(Flight_Revenue) FROM Flight_Boards GROUP BY MONTH(Departure_Date) HAVING MONTH(Departure_Date) = ?";

        ps = con.prepareStatement(query);
        ps.setString(1, month);
        rs = ps.executeQuery();

        out.println("<h3>Sales Report for Month: " + month + "</h3>");
        out.println("<table border='1'>");
        out.println("<tr><th>Month</th><th>Total Revenue</th></tr>");

        while (rs.next()) {
            int monthNumber = rs.getInt("MONTH(Departure_Date)");
            double totalRevenue = rs.getDouble("SUM(Flight_Revenue)");

            out.println("<tr>");
            out.println("<td>" + monthNumber + "</td>");
            out.println("<td>$" + totalRevenue + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");

    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
    %>

    <br><a href="adminHome.jsp">Back to Admin Dashboard</a>

</body>
</html>
