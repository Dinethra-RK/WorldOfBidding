<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.dineth.ee.ejb.AuctionStatus" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.dineth.ee.model.Bid" %><%--
  Created by IntelliJ IDEA.
  User: Dinethra
  Date: 5/30/2025
  Time: 9:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    InitialContext ctx = new InitialContext();
    AuctionStatus statusBean = (AuctionStatus) ctx.lookup("java:module/AuctionStatus");
    Map<String, Boolean> allStatus = statusBean.getAllAuctionStatuses();
    Map<String, Bid> highest = statusBean.getHighestBids();
%>

<table border="1" cellpadding="5">
    <tr>
        <th>Item ID</th>
        <th>Current Highest Bid</th>
    </tr>
    <%
        for (Map.Entry<String, Boolean> entry : allStatus.entrySet()) {
            if (entry.getValue()) {
                String itemId = entry.getKey();
                Bid bid = highest.get(itemId);
                double amount = (bid != null) ? bid.getAmount() : 0.0;
    %>
    <tr>
        <td><%= itemId %></td>
        <td>Rs. <%= amount %></td>
    </tr>
    <%
            }
        }
    %>
</table>
