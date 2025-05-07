<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Revenue</title>
</head>
<body>
<h2>View Revenue Summary</h2>

<form method="get">
    Filter by: 
    <select name="filter">
        <option value="Flight_Number">Flight Number</option>
        <option value="Airline_Name">Airline</option>
        <option value="Account_Number">Customer</option>
    </select>
    <input type="submit" value="View">
</form>

<%
String filter = request.getParameter("filter");

if (filter != null) {
    // Ensure filter is one of the allowed options
    String validFilter = null;
    String additionalJoin = "";
    String groupBy = "";
    String selectColumns = "";

    if (filter.equals("Flight_Number")) {
        validFilter = "Flight_Number";
        selectColumns = "Flight_Number";
        groupBy = "Flight_Number";
    } else if (filter.equals("Airline_Name")) {
        validFilter = "Airline_Name";
        selectColumns = "Flight_Boards.Airline_ID";
        groupBy = "Flight_Boards.Airline_ID";
        additionalJoin = " JOIN Flight_Boards ON Ticket.Flight_Number = Flight_Boards.Flight_Number";
    } else if (filter.equals("Account_Number")) {
        validFilter = "Account_Number";
        selectColumns = "Account_Number";
        groupBy = "Account_Number";
    }

    if (validFilter != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

            // Form the dynamic query based on the filter selected
            String query = "SELECT " + selectColumns + ", SUM(Total_Fair) AS Revenue " +
                           "FROM Ticket " + additionalJoin + 
                           " GROUP BY " + groupBy;

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);

            out.println("<table border='1'><tr><th>" + filter + "</th><th>Revenue</th></tr>");
            while (rs.next()) {
                out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getDouble("Revenue") + "</td></tr>");
            }
            out.println("</table>");

            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    } else {
        out.println("<p>Invalid filter selection</p>");
    }
}
%>

<br><a href="adminHome.jsp">Back to Admin Dashboard</a>
</body>
</html>
