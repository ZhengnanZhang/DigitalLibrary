<%--
  Created by IntelliJ IDEA.
  User: kk
  Date: 8/26/15
  Time: 13:31
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
    <title>Computer Science Bibliography</title>
    <link rel="stylesheet" type="text/css" href="/search/static/semantic.min.css"/>
    <link rel="stylesheet" type="text/css" href="/search/static/main.css"/>
    <script rel="text/javascript" src="/search/static/semantic.min.js"></script>
</head>

<div id="header" class="ui three item menu">
    <a class="item active" href="<%=request.getContextPath()%>/">Home</a>
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

        <div class="ui stacked raised segments">
            <%
                // generate random int, display book
                for (int i = 0; i < 12; i++) {
                    Random rand = new Random();
                    int randInt = rand.nextInt(22410) + 1;
                    pageContext.setAttribute("randInt", randInt);
            %>
            <div class="ui segment">
                <a href="<%=request.getContextPath()%>/book/${randInt}" target="_blank">
                    <x:out select="$parsedXML/dblp/article[$pageScope:randInt]/title"/>
                </a>
            </div>
            <%
                }
            %>
        </div>
    </div>


</div>

</body>
</html>
