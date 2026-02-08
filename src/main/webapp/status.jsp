<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.dineth.ee.ejb.AuctionStatus" %>
<%@ page import="com.dineth.ee.model.Bid" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: Dinethra
  Date: 5/27/2025
  Time: 7:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>World Of Bidding / Auction Status</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function loadTopBids() {
            $("#table-container").load("topBids.jsp");
        }

        $(document).ready(function () {
            loadTopBids();
            setInterval(loadTopBids, 5000);
        });
    </script>
</head>
<body>
    <h2>Current Highest Bids</h2>
    <h5>(Auto-refreshing every 5s)</h5>

    <div id="table-container">

    </div>
</body>
</html>
