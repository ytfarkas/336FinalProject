<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Most Active Flights</title>
</head>
<body>
    <h2>Most Active Flights (Most Tickets Sold)</h2>

    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

        // SQL query: count tickets per flight, order by ticket count descending
        String query = "SELECT Flight_Number, COUNT(*) AS Tickets_Sold " +
                       "FROM Reservation " +
                       "GROUP BY Flight_Number " +
                       "ORDER BY Tickets_Sold DESC";

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(query);

        // Display results in an HTML table
        out.println("<table>");
        out.println("<tr><th>Flight Number</th><th>Tickets Sold</th></tr>");

        while (rs.next()) {
            String flightNum = rs.getString("Flight_Number");
            int ticketsSold = rs.getInt("Tickets_Sold");

            out.println("<tr>");
            out.println("<td>" + flightNum + "</td>");
            out.println("<td>" + ticketsSold + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");

        con.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
    %>

    <br><a href="adminDashboard.jsp">Back to Admin Dashboard</a>

</body>
</html>
