<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
<title>Edit Users</title>
</head>
<body>
    <h2>Add, Edit, and Delete Users</h2>

    <%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject?useSSL=false&serverTimezone=UTC", "root", "mysqlpassword");

        String query = "SELECT * FROM Account WHERE Role = 'Customer' OR Role = 'Representative'";

        st = con.createStatement();
        rs = st.executeQuery(query);

        out.println("<table border='1'>");
        out.println("<tr><th>Account Number</th><th>First Name</th><th>Last Name</th><th>Username</th><th>Password</th><th>SSN</th><th>Role</th></tr>");

        while (rs.next()) {
            String accountNumber = rs.getString("Account_Number");
            String firstName = rs.getString("First_Name");
            String lastName = rs.getString("Last_Name");
            String username = rs.getString("Username");
            String password = rs.getString("Password");
            String ssn = rs.getString("SSN");
            String role = rs.getString("Role");

            out.println("<tr>");
            out.println("<td>" + accountNumber + "</td>");
            out.println("<td>" + firstName + "</td>");
            out.println("<td>" + lastName + "</td>");
            out.println("<td>" + username + "</td>");
            out.println("<td>" + password + "</td>");
            out.println("<td>" + ssn + "</td>");
            out.println("<td>" + role + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");

    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
    %>

    <br><a href="adminHome.jsp">Back to Admin Dashboard</a>

</body>
</html>
