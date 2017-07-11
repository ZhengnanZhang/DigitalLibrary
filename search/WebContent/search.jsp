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
    public static boolean checkInVector(Vector<String> v, String content) {
        boolean match = true;
        for (int j = 0; j < v.size(); j++) {
            if (!content.toLowerCase().trim().contains(v.get(j).toLowerCase().trim())) {
                match = false;
                break;
            }

        }
        return match;
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
    // get keyword
    String keyword = request.getParameter("keyword");
    String limit = "";

    if (keyword.trim().isEmpty()) {
%>
<div id="container" class="ui grid">
    <div class="ui segment">
        <div class="ui icon message">
            <i class="remove icon"></i>

            <div class="content">
                <div class="header">
                    Keyword is Empty!
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%

}
// keyword is not empty
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

    String[] keywordList = keyword.split("\\s+");
    // parse the :param keyword
    String result = "";
    String[] keywords = keyword.trim().toLowerCase().split("\\s+");
    Vector<String> v = new Vector<>(Arrays.asList(keywords));

    // search from which row


    if (keywordList[0].equals("author:")) {
        limit = "author";
    } else if (keywordList[0].equals("title:")) {
        limit = "title";
    } else if (keywordList[0].equals("pages:")) {
        limit = "pages";
    } else if (keywordList[0].equals("year:")) {
        limit = "year";
    } else if (keywordList[0].equals("volume:")) {
        limit = "volume";
    } else if (keywordList[0].equals("journal:")) {
        limit = "journal";
    } else if (keywordList[0].equals("number:")) {
        limit = "number";
    } else if (keywordList[0].equals("url:")) {
        limit = "url";
    } else if (keywordList[0].equals("ee:")) {
        limit = "ee";
    }
    out.println("Limit:" + limit);

    // new result number
    int resultNumber = 0;
    // mathed result
    int matchedResult = 0;

    // is no limit
    if (limit.isEmpty()) {
        for (int i = 1; i < maxSearchLimit && resultNumber < 11; i++) {
            pageContext.setAttribute("curIndex", i);
%>
<c:set var="curContent" scope="page">
    <x:out select="$parsedXML/dblp//article[$pageScope:curIndex]"/>
</c:set>
<%
        String content = (String) pageContext.getAttribute("curContent");
        boolean match = checkInVector(v, content);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
                continue;
            }
        }
    }
}

// if has limit
else {
    // remove the limit keyword
    v.remove(0);
    for (int i = 1; i < maxSearchLimit && resultNumber < 11; i++) {
        pageContext.setAttribute("curIndex", i);
        switch (limit) {
            case ("author"): {
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
        String author = (String) pageContext.getAttribute("curAuthor");

        boolean match = checkInVector(v, author);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;
    }
    case ("title"): {
%>
<c:set var="curTitle" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/title"/>
</c:set>
<%
        String title = (String) pageContext.getAttribute("curTitle");

        boolean match = checkInVector(v, title);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("pages"): {
%>
<c:set var="curPages" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/pages"/>
</c:set>
<%
        String pages = (String) pageContext.getAttribute("curPages");

        boolean match = checkInVector(v, pages);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("year"): {
%>
<c:set var="curYear" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/year"/>
</c:set>
<%
        String year = (String) pageContext.getAttribute("curYear");

        boolean match = checkInVector(v, year);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("volume"): {
%>
<c:set var="curVolume" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/volume"/>
</c:set>
<%
        String volume = (String) pageContext.getAttribute("curVolume");

        boolean match = checkInVector(v, volume);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("journal"): {
%>
<c:set var="curJournal" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/journal"/>
</c:set>
<%
        String journal = (String) pageContext.getAttribute("curJournal");

        boolean match = checkInVector(v, journal);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("number"): {
%>
<c:set var="curNumber" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/number"/>
</c:set>
<%
        String number = (String) pageContext.getAttribute("curNumber");

        boolean match = checkInVector(v, number);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("url"): {
%>
<c:set var="curUrl" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/url"/>
</c:set>
<%
        String url = (String) pageContext.getAttribute("curUrl");

        boolean match = checkInVector(v, url);
        if (match) {
            matchedResult++;
            if (matchedResult > offset) {
                resultNumber++;
                result += " " + Integer.toString(i) + " ";
            }
        }
        break;

    }
    case ("ee"): {
%>

<c:set var="curEe" scope="page">
    <x:out select="$parsedXML/dblp/article[$pageScope:curIndex]/ee"/>
</c:set>
<%
                    String ee = (String) pageContext.getAttribute("curEe");

                    boolean match = checkInVector(v, ee);
                    if (match) {
                        matchedResult++;
                        if (matchedResult > offset) {
                            resultNumber++;
                            result += " " + Integer.toString(i) + " ";
                        }
                    }
                    break;
                }
            }

        }


    }

    String hasNext = "";
    if (resultNumber == 11) {
        hasNext = "1";

        // if 11 result, cut result
        String[] tempResult = result.trim().split("\\s+");
        Vector<String> w = new Vector<>(Arrays.asList(tempResult));
        w.remove(w.size() - 1);
        result = String.join(" ", w) + " ";
        resultNumber--;
    }
    String offsetString = Integer.toString(offset + resultNumber);

%>

<c:redirect url="/result.jsp">
    <c:param name="result" value="<%= result %>"/>
    <c:param name="hasNext" value="<%= hasNext %>"/>
    <c:param name="offset" value="<%= offsetString %>"/>
    <c:param name="keyword" value="<%= keyword %>"/>
</c:redirect>
<%
    }
%>










