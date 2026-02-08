<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.dineth.ee.model.Bid" %>
<%@ page import="com.dineth.ee.ejb.AuctionManagerBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>World Of Bidding / Submit Bid</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f8fc;
            margin: 0;
            padding: 20px;
        }

        h2, h3, h5 {
            color: #2c3e50;
        }

        form {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            width: 350px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        #auction-items, #table-container {
            background: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
            margin-left: 20px;
            min-width: 400px;
        }

        table {
            border-collapse: collapse;
        }

        td {
            vertical-align: top;
        }

        hr {
            margin: 30px 0 10px;
        }

        .result-message {
            margin-top: 15px;
            color: green;
            font-weight: bold;
        }

        .error-message {
            margin-top: 15px;
            color: red;
        }
    </style>

    <script>
        function loadTopBids() {
            $("#table-container").load("topBids.jsp");
        }

        $(document).ready(function () {
            loadTopBids(); // Load once at start
            setInterval(loadTopBids, 5000); // Reload every 5 seconds
            loadAuctionItems();
            setInterval(loadAuctionItems, 10000);
        });
    </script>
</head>
<body>
<table>
    <tr>
        <td>
<h2>Place a Bid</h2>
<form method="post">
    Item ID: <input type="text" name="itemId" required><br><br>
    <%
        String bidderName = (String) session.getAttribute("username");
        String email = (String) session.getAttribute("email");

        if (bidderName == null || email == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    Your Name: <input type="text" name="bidderName" value="<%= bidderName %>" readonly><br><br>

    Bid Amount: <input type="number" step="0.01" name="amount" required><br><br>
    <input type="submit" value="Submit Bid">
</form>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String itemId = request.getParameter("itemId");
        bidderName = request.getParameter("bidderName");
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            InitialContext ctx = new InitialContext();

            com.dineth.ee.ejb.AuctionStatus statusBean = (com.dineth.ee.ejb.AuctionStatus) ctx.lookup("java:module/AuctionStatus");
            if (!statusBean.isAuctionOpen(itemId)) {
                out.println("<p class='error-message'>Bidding is closed for this item.</p>");
                return;
            }

            AuctionManagerBean bean = (AuctionManagerBean) ctx.lookup("java:module/AuctionManagerBean");


            Bid bid = new Bid(itemId, bidderName, amount);
            String result = bean.submitBid(bid);

            out.println("<p class='result-message'>" + result + "</p>");
        } catch (NamingException e) {
            out.println("<pre class='error-message'>" + e + "</pre>");

        }
    }
%>
        </td>
        <td style="vertical-align: top;">
            <h3>Items Currently on Auction</h3>
            <div id="auction-items"></div>
        </td>
    </tr>
</table>

<script>
    function loadAuctionItems() {
        $("#auction-items").load("auctionItems.jsp");
    }

    $(document).ready(function () {
        loadAuctionItems(); // initial
        setInterval(loadAuctionItems, 10000); // refresh every 10 seconds
    });
</script>

<hr>
<h3>⏱ Live Bidding Status</h3>
<h5>(Auto-refreshes every 5s)</h5>
<div id="table-container"></div>
</body>
</html>
