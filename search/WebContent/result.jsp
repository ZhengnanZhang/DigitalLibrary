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

<%
    String result = "";
    if (request.getParameter("result") != null) {
        result = request.getParameter("result").trim();
    }

    String hasNext = "";
    if (request.getParameter("hasNext") != null) {
        hasNext = request.getParameter("hasNext").trim();
    }
    int offset = 0;
    if (!request.getParameter("offset").trim().isEmpty()) {
        offset = Integer.parseInt(request.getParameter("offset"));
    }

    String keyword = "";
    if (request.getParameter("keyword") != null) {
        keyword = request.getParameter("keyword").trim();
    }
%>

<html>
<head>
    <title>Result</title>
    <link rel="stylesheet" type="text/css" href="/search/static/semantic.min.css"/>
    <link rel="stylesheet" type="text/css" href="/search/static/main.css"/>
    <script rel="text/javascript" src="/search/static/semantic.min.js"></script>
</head>

<div id="header" class="ui three item menu">
    <a class="item" href="<%=request.getContextPath()%>/">Home</a>
    <a class="item" href="<%=request.getContextPath()%>/advancedsearch/">Advanced Search</a>
    <a class="item">Shopping Cart</a>
</div>

<%


    if (result.trim().isEmpty()) {
%>
<div id="container" class="ui grid">
    <div class="ui segment">
        <div class="ui icon message">
            <i class="remove icon"></i>

            <div class="content">
                <div class="header">
                    Sorry, no matching datasets found!
                </div>
            </div>
        </div>
    </div>
</div>
<%
} else {
%>
<div id="container" class="ui grid">
    <div class="sixteen wide column">
        <div class="ui stacked raised segments">
            <%
                String[] books = result.trim().split("\\s+");
                for (int i = 0; i < books.length; i++) {
                    pageContext.setAttribute("bookID", Integer.parseInt(books[i]));
            %>

            <div class="ui segment">
                <a class="header" href="<%=request.getContextPath()%>/book/${bookID}" target="_blank"><x:out
                        select="$parsedXML/dblp/article[$pageScope:bookID]/title"/></a>
            </div>

            <%
                }

            %>
        </div>
        <%
            if (offset > 10) {
                int prevOffset = offset - 20;
                if (prevOffset < 0) {
                    prevOffset = 0;
                }
                String prevOffsetString = Integer.toString(prevOffset);
        %>
        <form class="ui form" method="get" action="<%=request.getContextPath()%>/search.jsp">
            <div class="field">
                <input type="hidden" name="keyword" value="<%= keyword%>">
            </div>
            <div class="field">
                <input type="hidden" name="offset" value="<%= prevOffsetString%>">
            </div>
            <button class="ui button secondary" type="submit">Prev</button>
        </form>
        <%
            }
            if (!hasNext.isEmpty()) {
        %>
        <form class="ui form" method="get" action="<%=request.getContextPath()%>/search.jsp">
            <div class="field">
                <input type="hidden" name="keyword" value="<%= keyword%>">
            </div>
            <div class="field">
                <input type="hidden" name="offset" value="<%= offset%>">
            </div>
            <button class="ui button secondary" type="submit">Next</button>
        </form>
        <%
            }
        %>
    </div>
</div>
<%
    }
%>


</body>
</html>

