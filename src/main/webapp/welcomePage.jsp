<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
</head>
<body>
	<h1>What Would You Like To Do?</h1>
	<form action="flightSearch.jsp" method="get">
		<button type="submit">Search For Flights</button>
	</form>
	<form action="upcomingFlight.jsp" method="get">
		<button type="submit">Your Upcoming Flights</button>
	</form>
	<form action="viewPastFlights.jsp" method="get">
		<button type="submit">View Past Flights</button>
	</form>
	<form action="questionAndAnswer.jsp" method="get">
		<button type="submit">Q&A</button>
	</form>
	<form action="viewWaitlist.jsp" method="get">
		<button type="submit">View Waitlist</button>
	</form>
	<form action="contactCustomerRep.jsp" method="get">
		<button type="submit">Post a Question to Customer
			Representative</button>
	</form>

	<a href='logout.jsp'>Log Out</a>

</body>
</html>