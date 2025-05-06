<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
if ((session.getAttribute("user") == null)) {
%>
You are not logged in
</br>

<%
} 
else {
response.sendRedirect("welcomePage.jsp");
}
%>

