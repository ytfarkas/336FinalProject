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

<!-- Example: Display users -->
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

    String query = "SELECT * FROM Account WHERE Role = 'Customer' OR Role = 'Representative'";
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(query);

    out.println("<table border='1'><tr><th>Account Number</th><th>Name</th><th>Role</th><th>Action</th></tr>");
    while (rs.next()) {
        String accNum = rs.getString("Account_Number");
        String name = rs.getString("First_Name") + " " + rs.getString("Last_Name");
        String role = rs.getString("Role");

        out.println("<tr>");
        out.println("<td>" + accNum + "</td><td>" + name + "</td><td>" + role + "</td>");
        out.println("<td><a href='deleteUser.jsp?account=" + accNum + "'>Delete</a></td>");
        out.println("</tr>");
    }
    out.println("</table>");

    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>

<br><a href="adminHome.jsp">Back to Admin Dashboard</a>
</body>
</html>
