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
%>
Welcome 
<%session.getAttribute("user");%>
<a href='logout.jsp'>Log Out</a>
<%
}
%>
