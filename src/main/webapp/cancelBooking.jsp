<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>
<%

  Integer acctNum = (Integer) session.getAttribute("user");
  if (acctNum == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  //Find booking
  String instanceID = request.getParameter("instanceID");
  if (instanceID != null && !instanceID.isEmpty()) {
    Connection con = null;
    PreparedStatement ps = null;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/336AirlineProject",
        "root", "mysqlpassword");

      //delete booking
      String deleteSql = 
        "DELETE FROM Bookings " +
        " WHERE Account_Number = ? AND Instance_ID = ?";
      ps = con.prepareStatement(deleteSql);
      ps.setInt(1, acctNum);
      ps.setInt(2, Integer.parseInt(instanceID));
      ps.executeUpdate();



    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (ps != null) {
        try { ps.close(); }
        catch (Exception ignore) {}
      }
      if (con != null) {
        try { con.close(); }
        catch (Exception ignore) {}
      }
    }
  }
  //go back to reservations tab
  response.sendRedirect("customerUpcomingFlight.jsp");
%>
