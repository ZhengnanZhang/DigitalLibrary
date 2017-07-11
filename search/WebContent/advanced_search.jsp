<%--
  Created by IntelliJ IDEA.
  User: kk
  Date: 9/2/15
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Processing</title>
    <link rel="stylesheet" type="text/css" href="/search/static/semantic.min.css"/>
    <link rel="stylesheet" type="text/css" href="/search/static/main.css"/>
    <script rel="text/javascript" src="/search/static/semantic.min.js"></script>
</head>

<div id="header" class="ui three item menu">
    <a class="item" href="<%=request.getContextPath()%>/">Home</a>
    <a class="item active" href="<%=request.getContextPath()%>/advancedsearch/">Advanced Search</a>
    <a class="item" href="<%=request.getContextPath()%>/cart">Shopping Cart</a>
</div>

<div id="container" class="ui grid">
    <div class="sixteen wide column">
    <div class="ui segments">
        <div class="ui segment">
        <form class="ui form" method="get" action="<%=request.getContextPath()%>/advanced_search_backend.jsp">
            <div class="field">
                <input type="text" name="title" placeholder="Title">
            </div>
            <div class="field">
                <input type="text" name="author" placeholder="Author">
            </div>
            <div class="field">
                <input type="text" name="pages" placeholder="Pages">
            </div>
            <div class="field">
                <input type="text" name="year" placeholder="Year">
            </div>
            <div class="field">
                <input type="text" name="volume" placeholder="Volume">
            </div>
            <div class="field">
                <input type="text" name="journal" placeholder="Journal">
            </div>
            <div class="field">
                <input type="text" name="number" placeholder="Number">
            </div>
            <div class="field">
                <input type="text" name="url" placeholder="Url">
            </div>
            <div class="field">
                <input type="text" name="ee" placeholder="ee">
            </div>

            <button class="ui button" type="submit">Search</button>
        </form>
    </div>
        </div>
        </div>
</div>


</body>
</html>
