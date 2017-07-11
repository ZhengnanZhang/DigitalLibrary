<%--
  Created by IntelliJ IDEA.
  User: kk
  Date: 9/2/15
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ page import="java.util.*" %>

<c:if test="${applicationScope.parsedXML == null}">
    <c:import var="xml" url="/static/dblp.xml"/>
    <x:parse var="parsedXML" xml="${xml}" scope="application"/>
</c:if>

<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" type="text/css" href="/search/static/semantic.min.css"/>
    <link rel="stylesheet" type="text/css" href="/search/static/main.css"/>
    <script rel="text/javascript" src="/search/static/semantic.min.js"></script>
</head>

<div id="header" class="ui three item menu">
    <a class="item" href="<%=request.getContextPath()%>/">Home</a>
    <a class="item" href="<%=request.getContextPath()%>/advancedsearch/">Advanced Search</a>
    <a class="item active">Shopping Cart</a>
</div>

<%
    String originalBookNumber = "";
    Cookie cookie = null;
    Cookie[] cookies = null;

    //originalBookNumber=cookie["booknumber"]
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

    if (originalBookNumber.trim().isEmpty()) {
%>
<div id="container" class="ui grid">
    <div class="ui segment">
        <div class="ui icon message">
            <i class="remove icon"></i>

            <div class="content">
                <div class="header">
                    Shopping Cart is Empty!
                </div>
            </div>
        </div>
    </div>
</div>
<%
} else {
%>
<div id="container" class="ui grid">
    <div class="ui stacked raised segments">
        <div class="ui relaxed divided list" id="mainContent">
            <%
                String[] books = originalBookNumber.trim().split("\\s+");


                // parse the quantity of each kind of book
                Hashtable<String, Integer> booksAndNumber = new Hashtable<>();
                for (int i = 0; i < books.length; i++) {

                    if (!booksAndNumber.containsKey(books[i])) {
                        booksAndNumber.put(books[i], 1);
                    } else {
                        booksAndNumber.put(books[i], booksAndNumber.get(books[i]) + 1);
                    }
                }
                Enumeration names;
                names = booksAndNumber.keys();

                while (names.hasMoreElements()) {
                    String bookID = (String) names.nextElement();
                    int bookQuantity = booksAndNumber.get(bookID);
                    pageContext.setAttribute("bookID", Integer.parseInt(bookID));
            %>
            <div class="item">
                <i class="large book middle aligned icon"></i>

                <div class="content">
                    <a class="header" href="<%=request.getContextPath()%>/book/<%= bookID %>" target="_blank"><x:out
                            select="$parsedXML/dblp/article[$pageScope:bookID]/title"/></a>

                    <div class="description">Quantity:<%= bookQuantity %>
                    </div>
                    <a class="description" href="<%=request.getContextPath()%>/removeone/<%= bookID%>">remove 1 item</a>

                    <a class="description" href="<%=request.getContextPath()%>/removeall/<%= bookID%>">remove all item</a>
                </div>
            </div>

            <%
                }

            %>
        </div>
    </div>
</div>
<%
    }
%>


</body>
</html>
