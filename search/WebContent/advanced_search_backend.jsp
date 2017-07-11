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

<%
    // the maxium row to search
    int maxSearchLimit = 100;

    // start number of the result
    int offset = 0;
    if (request.getParameter("offset") != null) {
        offset = Integer.parseInt(request.getParameter("offset"));
    }

%>

<%!
    public static boolean checkInString(String content, String keyword) {
        return content.toLowerCase().trim().contains(keyword.toLowerCase().trim());
    }
%>

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


<%
    // get parameters
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String pages = request.getParameter("pages");
    String year = request.getParameter("year");
    String volume = request.getParameter("volume");
    String journal = request.getParameter("journal");
    String number = request.getParameter("number");
    String url = request.getParameter("url");
    String ee = request.getParameter("ee");

    // all of the search fields are empty
    if (title.trim().isEmpty() && author.trim().isEmpty() && pages.trim().isEmpty() && year.trim().isEmpty() && volume.trim().isEmpty() && journal.trim().isEmpty() && number.trim().isEmpty() && url.trim().isEmpty() && ee.trim().isEmpty()) {
%>
<div id="container" class="ui grid">
    <div class="ui segment">
        <div class="ui icon message">
            <i class="remove icon"></i>

            <div class="content">
                <div class="header">
                    All of the search fields are Empty!
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%

}
// not all of the search fields are empty
else {
%>
<div id="container" class="ui grid">
    <div class="ui segment" id="progress">
        <div class="ui inverted active dimmer">
            <div class="ui text loader">Proceeding</div>
        </div>
        <p></p>
    </div>
</div>
</body>
</html>
<%

    String result = "";

    // new result number
    int resultNumber = 0;
    // mathed result
    int matchedResult = 0;

    for (int i = 1; i < maxSearchLimit && resultNumber < 11; i++) {
        pageContext.setAttribute("curIndex", i);

%>
<c:set var="curAuthor" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/author[0]"/>
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/author[1]"/>
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/author[2]"/>
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/author[3]"/>
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/author[4]"/>
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/author[5]"/>
</c:set>
<%
    String tempAuthor = (String) pageContext.getAttribute("curAuthor");
    if (!checkInString(tempAuthor, author)) {
        continue;
    }
%>
<c:set var="curTitle" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/title"/>
</c:set>
<%
    String tempTitle = (String) pageContext.getAttribute("curTitle");
    if (!checkInString(tempTitle, title)) {
        continue;
    }

%>
<c:set var="curPages" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/pages"/>
</c:set>
<%
    String tempPages = (String) pageContext.getAttribute("curPages");

    if (!checkInString(tempPages, pages)) {
        continue;
    }

%>
<c:set var="curYear" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/year"/>
</c:set>
<%
    String tempYear = (String) pageContext.getAttribute("curYear");

    if (!checkInString(tempYear, year)) {
        continue;
    }
%>
<c:set var="curVolume" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/volume"/>
</c:set>
<%
    String tempVolume = (String) pageContext.getAttribute("curVolume");
    if (!checkInString(tempVolume, volume)) {
        continue;
    }
%>
<c:set var="curJournal" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/journal"/>
</c:set>
<%
    String tempJournal = (String) pageContext.getAttribute("curJournal");

    if (!checkInString(tempJournal, journal)) {
        continue;
    }
%>
<c:set var="curNumber" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/number"/>
</c:set>
<%
    String tempNumber = (String) pageContext.getAttribute("curNumber");

    if (!checkInString(tempNumber, number)) {
        continue;
    }
%>
<c:set var="curUrl" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/url"/>
</c:set>
<%
    String tempUrl = (String) pageContext.getAttribute("curUrl");
    if (!checkInString(tempUrl, url)) {
        continue;
    }
%>

<c:set var="curEe" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/ee"/>
</c:set>
<%
        String tempEe = (String) pageContext.getAttribute("curEe");
        if (!checkInString(tempEe, ee)) {
            continue;
        }
        matchedResult++;
        if (matchedResult > offset) {
            resultNumber++;
            result += " " + Integer.toString(i) + " ";
        }
    }

    // update cookie


    String hasNext = "";
    if (resultNumber == 11) {
        hasNext = "1";

        // if 11 result, cut result
        String[] tempResult = result.trim().split("\\s+");
        Vector<String> v = new Vector<>(Arrays.asList(tempResult));
        v.remove(v.size() - 1);
        result = String.join(" ", v) + " ";
        resultNumber--;
    }

    String offsetString = Integer.toString(offset + resultNumber);


%>

<c:redirect url="search/advanced_result.jsp">
    <c:param name="result" value="<%= result %>"/>
    <c:param name="hasNext" value="<%= hasNext %>"/>
    <c:param name="offset" value="<%= offsetString %>"/>
    <c:param name="title" value="<%= title %>"/>
    <c:param name="author" value="<%= author %>"/>
    <c:param name="pages" value="<%= pages %>"/>
    <c:param name="year" value="<%= year %>"/>
    <c:param name="volume" value="<%= volume %>"/>
    <c:param name="journal" value="<%= journal %>"/>
    <c:param name="number" value="<%= number %>"/>
    <c:param name="url" value="<%= url %>"/>
    <c:param name="ee" value="<%= ee %>"/>
</c:redirect>
<%
    }

%>











