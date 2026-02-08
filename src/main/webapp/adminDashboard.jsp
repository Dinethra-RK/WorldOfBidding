<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.dineth.ee.ejb.AuctionStatus" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: Dinethra
  Date: 5/29/2025
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
if (isAdmin == null || !isAdmin) {
response.sendRedirect("adminLogin.jsp");
return;
}
  InitialContext ctx = new InitialContext();
  AuctionStatus statusBean = (AuctionStatus) ctx.lookup("java:module/AuctionStatus");

  String action = request.getParameter("action");
  String itemId = request.getParameter("itemId");

  if ("start".equals(action) && itemId != null && !itemId.trim().isEmpty()) {
    statusBean.startAuction(itemId);
  } else if ("stop".equals(action) && itemId != null && !itemId.trim().isEmpty()) {
    statusBean.closeAuction(itemId);
  }

  Map<String, Boolean> statusMap = statusBean.getAllAuctionStatuses();
%>

<html>
<head>
    <title>World Of Bidding / Admin Dashboard</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f7fb;
      margin: 0;
      padding: 40px;
      color: #333;
    }

    h2 {
      color: #2a6592;
    }

    form {
      margin-bottom: 20px;
    }

    input[type="text"], input[type="submit"] {
      padding: 8px 12px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    input[type="submit"] {
      background-color: #2a6592;
      color: white;
      font-weight: bold;
      cursor: pointer;
    }

    input[type="submit"]:hover {
      background-color: #1d4d73;
    }

    table {
      border-collapse: collapse;
      width: 100%;
      margin-top: 20px;
    }

    table, th, td {
      border: 1px solid #ccc;
    }

    th {
      background-color: #e9f1f8;
      color: #2a6592;
      padding: 10px;
    }

    td {
      padding: 10px;
      text-align: center;
    }

    .status-open {
      color: green;
      font-weight: bold;
    }

    .status-closed {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>
<h2>🛠️ Admin Dashboard - Auction Control</h2>

<!-- Add new auction item -->
<form method="get">
  <label for="itemId">Add New Item:</label>
  <input type="text" name="itemId" id="itemId" required>
  <input type="hidden" name="action" value="start">
  <input type="submit" value="Start Auction">
</form>

<br><br>
<!-- Auction status table -->
<table border="1" cellpadding="5">
  <tr>
    <th>Item ID</th>
    <th>Status</th>
    <th>Action</th>
  </tr>
  <%
    for (Map.Entry<String, Boolean> entry : statusMap.entrySet()) {
      String id = entry.getKey();
      boolean open = entry.getValue();
  %>
  <tr>
    <td><%= id %></td>
    <td><%= open ? "🟢 Open" : "🔴 Closed" %></td>
    <td>
      <form method="get" style="display:inline;">
        <input type="hidden" name="itemId" value="<%= id %>">
        <input type="hidden" name="action" value="<%= open ? "stop" : "start" %>">
        <input type="submit" value="<%= open ? "Close" : "Start" %>">
      </form>
    </td>
  </tr>
  <%
    }
  %>
</table>
</body>
</html>
