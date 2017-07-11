<%--
  Created by IntelliJ IDEA.
  User: kk
  Date: 8/28/15
  Time: 13:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>

<c:if test="${applicationScope.parsedXML == null}">
    <c:import var="xml" url="/static/dblp.xml"/>
    <x:parse var="parsedXML" xml="${xml}" scope="application"/>
</c:if>
<%
    // get book number
    String url = request.getRequestURI().toString();
    String regex = "\\d+";
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(url);
    String bookNumber = "";
    if (m.find()) {
        bookNumber = m.group(0);
    }
    pageContext.setAttribute("bookNumber", Integer.parseInt(bookNumber));

%>
<html>
<head>
    <title><x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/title"/></title>
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
    <div class="sixteen wide column">
        <form class="ui form" action="<%=request.getContextPath()%>/search.jsp" method="get" target="_blank">
            <div class="field">
                <input type="text" name="keyword" placeholder="Search...">
            </div>
            <button class="ui button secondary" type="submit">Submit</button>
        </form>

        <h3 class="ui header"><x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/title"/></h3>

        <div id="bookInfo" class="ui stacked raised segments">
            <div class="ui relaxed divided list">
                <div class="item">
                    <p>Author:
                        <x:forEach select="$parsedXML/dblp/article[$pageScope:bookNumber]/author" var="author">
                            <x:out select="$author"/>,
                        </x:forEach>
                    </p>
                </div>
                <div class="item">
                    <p>Pages: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/pages"/></p>
                </div>
                <div class="item">
                    <p>Year: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/year"/></p>
                </div>
                <div class="item">
                    <p>Volume: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/volume"/></p>
                </div>
                <div class="item">
                    <p>Journal: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/journal"/></p>
                </div>
                <div class="item">
                    <p>Number: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/number"/></p>
                </div>
                <div class="item">
                    <p>Url: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/url"/></p>
                </div>
                <div class="item">
                    <p>ee: <x:out select="$parsedXML/dblp/article[$pageScope:bookNumber]/ee"/></p>
                </div>

            </div>
        </div>
        <form class="ui form" action="<%=request.getContextPath()%>/add_book.jsp" method="get">
            <input type="hidden" name="bookNumber" value="<%= bookNumber%>">
            <input type="hidden" name="url" value="<%= url%>">
            <button class="ui active button" class="ui button" type="submit">
                <i class="add to cart icon"></i>
                Add to cart
            </button>
        </form>

    </div>

</div>

</body>
</html>
