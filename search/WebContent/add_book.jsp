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
    <a class="item" href="<%=request.getContextPath()%>/advancedsearch/">Advanced Search</a>
    <a class="item" href="<%=request.getContextPath()%>/cart">Shopping Cart</a>
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
    // find the book to add: bookNumber
    String originalBookNumber = "";
    String bookNumber = request.getParameter("bookNumber");
    String url = request.getParameter("url");


    // originalBookNumber = cookie["bookNumber"]
    Cookie cookie = null;
    Cookie[] cookies = null;

    cookies = request.getCookies();
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            cookie = cookies[i];
//            out.print("Name : " + cookie.getName( ) + ",  ");
//            out.print("Value: " + cookie.getValue( )+" <br/>");

            if (cookie.getName().equals("bookNumber")) {
                originalBookNumber = cookie.getValue();
                break;
            }
        }
    }
//    in this version, there is no duplicated books
//    if (!originalBookNumber.isEmpty())
//    {
//        Boolean isNewBook=true;
//        String[] originalBooks=originalBookNumber.split("\\s+");
//        for(int i=0;i<originalBooks.length;i++){
//            if (originalBooks[i].equals(bookNumber)){
//                isNewBook=false;
//            }
//        }
//        if (isNewBook){
//            Cookie book = new Cookie("bookNumber",originalBookNumber+bookNumber+" ");
//            book.setMaxAge(60*60*24);
//            response.addCookie( book );
//        }
//    }
//    else{
//        Cookie book = new Cookie(bookNumber+" ");
//        book.setMaxAge(60*60*24);
//        response.addCookie( book );
//    }

    // update cookie
    Cookie book = new Cookie("bookNumber", originalBookNumber + " " + bookNumber + " ");
    book.setMaxAge(60 * 60 * 24);
    book.setPath("/");
    response.addCookie(book);

    // rediret
    String content="0.1"+";URL="+url;
    response.setHeader("REFRESH",content);
%>

</body>
</html>
