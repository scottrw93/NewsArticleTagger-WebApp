<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="newstagger.webapp.article.*" %>
<%@ page import="newstagger.webapp.utils.*" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <title>
    Company Tagger
	</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->

    <link href="css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="css/sticky-footer-navbar.css" rel="stylesheet">
    <meta name="keywords" content="News, Tagging, NER">
    <meta name="description" content="Tagged News Streams">

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-60386807-1', 'auto');
  ga('send', 'pageview');

</script>
</head>

<body>

<div id="wrap">
     <div class="navbar navbar-default navbar-fixed-top " role="navigation">
        <div class="container">
            <div class="navbar-header">

                <div class="navbar-brand navbar-link" style="color: purple; font-size: 28px ; font-weight: bold">Company Tagger</div>

                <div style="font-size: 14px; ">Tagged News Items</div>
            </div>
            <div class="collapse navbar-collapse" style="font-size: 16px;">
                <ul class="nav navbar-nav">
                    <li><a></a></li>
                    <li class="dropdown"><a href="index"> Latest Articles</a></li>
                </ul>

            </div>
        </div>
    </div>

    <div class="container site-body " align="center">

    <div class="col-md-10 col-md-offset-1">
        <div id="update_div">
            <%
            HashMap<String, Articles> articles = (HashMap<String, Articles>) request.getAttribute("articles");

            for(String key : articles.keySet()){
            %>
                <table class="table table-hover table-striped" style="margin-top: 40px;">
                    <thead>
                    <tr>
                        <th class="col-md-7" style="text-align: center; font-size:20px">
                            <a href="" style="color: black; font-size: 22px ; font-weight: bold"><%= MapUtils.convertFeedToTitle(key) %> Articles</a>
                        </th>
                        <th class="col-md-1" style="text-align: center; font-size:20px">Tags</th>
                        <th class="col-md-3" style="text-align: center;font-size:20px">Time Published (UTC)</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                    	for(Article article : articles.get(key).articles()){
                        %>
                        <tr>
                            <td><a href="articleview?key=<%= article.getKey() %>"><%= article.getHeadline() %></a></td>
                            <th class="col-md-1" style="text-align: center; font-size:20px"> <%= article.getNumTags() %> </th>
                            <td style="text-align: center; vertical-align: middle"> <%= article.getDateAsString() %> </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            <%
            }
            %>
        </div>
    </div>
</div>

</body>

</html>
