<%--
  Created by IntelliJ IDEA.
  User: Dinethra
  Date: 5/29/2025
  Time: 4:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>World Of Bidding / Admin Login</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f7fb;
      color: #333;
      margin: 0;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .container {
      text-align: center;
    }

    h2 {
      color: #2a6592;
      margin-bottom: 20px;
    }

    form {
      background-color: #fff;
      padding: 30px 40px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      display: inline-block;
      min-width: 300px;
    }

    input[type="password"], input[type="submit"] {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
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

    .error {
      color: red;
      margin-top: 15px;
      font-weight: bold;
    }
  </style>
</head>
<body>
<div class="container">
<h2>Admin Login</h2>
<form method="post">
  Password: <input type="password" name="adminPass" required><br><br>
  <input type="submit" value="Login">
</form>
<%
  String correctPassword = "admin123";

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String inputPass = request.getParameter("adminPass");

    if (correctPassword.equals(inputPass)) {
      session.setAttribute("isAdmin", true);
      response.sendRedirect("adminDashboard.jsp");
    } else {
      out.println("<p style='color:red;'> Incorrect password</p>");
    }
  }
%>
</div>
</body>
</html>
