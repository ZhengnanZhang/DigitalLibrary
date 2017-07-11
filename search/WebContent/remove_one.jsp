<%--
  Created by IntelliJ IDEA.
  User: kk
  Date: 9/2/15
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Arrays" %>
<html>
<head>
    <title>Processing</title>
    <link rel="stylesheet" type="text/css" href="/search/static/semantic.min.css"/>
    <link rel="stylesheet" type="text/css" href="/search/static/main.css"/>
    <script rel="text/javascript" src="/search/static/semantic.min.js"></script>
</head>


<div id="header" class="ui three item menu">
    <a class="item" href="<%=request.getContextPath()%>/">Home</a>
    <a class="item" href="<%=request.getContextPath()%>/advancedsearch/">Advanced Search</a>
    <a class="item active" href="<%=request.getContextPath()%>/cart">Shopping Cart</a>
</div>

<div id="container" class="ui grid">
    <div class="ui segment" id="progress">
        <div class="ui inverted active dimmer">
            <div class="ui text loader">Proceeding</div>
        </div>
        <p></p>
    </div>
</div>

<%
    // find the book to remove: bookNumber
    String url = request.getRequestURI().toString();
    String regex = "\\d+";
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(url);
    String bookNumber = "";
    if (m.find()) {
        bookNumber = m.group(0);
    }


    // find the original cookie["bookNumber"]: originalBookNumber
    String originalBookNumber = "";
    Cookie cookie = null;
    Cookie[] cookies = null;

    cookies = request.getCookies();
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            cookie = cookies[i];

            if (cookie.getName().equals("bookNumber")) {
                originalBookNumber = cookie.getValue();
                break;
            }
        }
    }

    // remove one bookNumber from originalBookNumber, construct new string newBooks
    String[] books = originalBookNumber.trim().split("\\s+");
    Vector<String> v = new Vector<>(Arrays.asList(books));
    for (int i = 0; i < v.size(); i++) {
        if (v.get(i).equals(bookNumber)) {
            v.remove(i);
            break;
        }
    }


    // update cookie
    String newBooks = String.join(" ", v) + " ";
    Cookie book = new Cookie("bookNumber", newBooks);
    book.setMaxAge(60 * 60 * 24);
    book.setPath("/");
    response.addCookie(book);

    // redirect to cart

    String URL = "/cart";
    String content = "0.1" + ";URL=" + URL;
    response.setHeader("REFRESH", content);
%>

</body>
</html>
