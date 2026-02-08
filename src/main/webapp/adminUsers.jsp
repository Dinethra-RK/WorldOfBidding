<%@ page import="com.dineth.ee.ejb.AuctionStatus" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page session="true" %>
<%--
  Created by IntelliJ IDEA.
  User: Dinethra
  Date: 5/29/2025
  Time: 9:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    InitialContext ctx = new InitialContext();
    AuctionStatus statusBean = (AuctionStatus) ctx.lookup("java:module/AuctionStatus");

    Map<String, Set<String>> userMap = statusBean.getAllUserParticipation();
%>

<html>
<head>
    <title>World of Bidding / Admin / User Participants</title>
</head>
<body>
<h2>👥 User Participation by Auction Item</h2>

<table border="1" cellpadding="5">
    <tr>
        <th>Item ID</th>
        <th>Users</th>
    </tr>
    <%
        for (Map.Entry<String, Set<String>> entry : userMap.entrySet()) {
            String itemId = entry.getKey();
            Set<String> users = entry.getValue();
    %>
    <tr>
        <td><%= itemId %></td>
        <td><%= String.join(", ", users) %></td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
