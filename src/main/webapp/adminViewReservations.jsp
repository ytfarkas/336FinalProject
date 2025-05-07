<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Reservations</title>
</head>
<body>
<h2>View Reservations</h2>

<form method="get">
    Flight Number: <input type="text" name="flightNum">
    OR Customer Name: <input type="text" name="custName">
    <input type="submit" value="Search">
</form>

<%
String flightNum = request.getParameter("flightNum");
String custName = request.getParameter("custName");

if (flightNum != null || custName != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

        String query = "SELECT * FROM Reservation";
        if (flightNum != null && !flightNum.isEmpty()) {
            query += " WHERE Flight_Number = '" + flightNum + "'";
        } else if (custName != null && !custName.isEmpty()) {
            query += " WHERE Account_Number IN (SELECT Account_Number FROM Account WHERE CONCAT(First_Name, ' ', Last_Name) LIKE '%" + custName + "%')";
        }

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(query);

        out.println("<table border='1'><tr><th>Reservation Number</th><th>Flight Number</th><th>Account</th><th>Total Cost</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getString("Reservation_Number") + "</td><td>" + rs.getString("Flight_Number") + "</td><td>" + rs.getString("Account_Number") + "</td><td>" + rs.getDouble("Total_Cost") + "</td></tr>");
        }
        out.println("</table>");

        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>

<br><a href="adminHome.jsp">Back to Admin Dashboard</a>
</body>
</html>
