<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.dineth.ee.ejb.AuctionStatus" %>
<%@ page import="com.dineth.ee.model.Bid" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: Dinethra
  Date: 5/27/2025
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        font-size: 14px;
        color: #333;
    }
    h3 {
        color: #2a6592;
        margin-top: 20px;
    }
    p {
        font-weight: bold;
        margin-bottom: 10px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #f9f9f9;
        margin-bottom: 20px;
    }
    th {
        background-color: #2a6592;
        color: white;
        padding: 8px;
        text-align: left;
    }
    td {
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }
    tr:nth-child(even) {
        background-color: #f0f8ff;
    }
</style>
<%
    try {
        InitialContext ctx = new InitialContext();
        AuctionStatus statusBean = (AuctionStatus) ctx.lookup("java:module/AuctionStatus");

        Map<String, Bid> topBids = statusBean.getHighestBids();

        if (topBids.isEmpty()) {
            out.println("<p>No bids have been placed yet.</p>");
        } else {
            for (Map.Entry<String, Bid> entry : topBids.entrySet()) {
                String itemId = entry.getKey();
                Bid highestBid = entry.getValue();
                List<Bid> recentList = statusBean.getRecentBidsForItem(itemId);
%>
<h3>Item ID: <%= itemId %></h3>
<p>Highest Bid: $<%= highestBid.getAmount() %> by <%= highestBid.getBidderName() %></p>
<table border="1" cellpadding="5">
    <tr>
        <th>Bidder</th>
        <th>Amount</th>
        <th>Time</th>
    </tr>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (Bid b : recentList) {
    %>
    <tr>
        <td><%= b.getBidderName() %></td>
        <td>$<%= b.getAmount() %></td>
        <td><%= sdf.format(b.getBidTime()) %></td>
    </tr>
    <%
        }
    %>
</table>
<br><br>

<%
            }
        }
    } catch (Exception e) {
        out.println("<p>Error retrieving bids: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>
