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
    	Company Tagger - Article Summary
	</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->

    <link href="css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="css/sticky-footer-navbar.css" rel="stylesheet">
    <meta name="keywords" content="News, Tagging, NER">
    <meta name="description"
          content="Tagged News Streams">

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
                    <li><a href="index"> Latest Articles</a></li>
                    <li><a href="orgfilter?org="> Filter by Organisation</a></li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>

    <div class="container site-body " align="center">

    <% Article article = (Article) request.getAttribute("article"); %>

    <header class="page-header">
        <h2><%= article.getHeadline() %><br>
        	<small><%= article.getSummary() %></small>
        </h2>
    </header>

    <div class="row" style="border-bottom:1px solid #eee;" float="left">
        <div id="article" class="col-md-6"
             style="overflow-x:hidden;overflow-y:scroll; height: 1000px; border-right:1px solid #eee;">
                <article class="text-left">
                	<h2 style="color: blue; font-size: 24px ; font-weight: bold"> Article</h2>
                    <strong><%= article.getDateAsString() %></strong><br>
                    <p style="margin-top: 18px;">
                    	<%= article.getText() %>
                    </p>
                    <br>
					 <a href="<%= article.getUrl() %>"><%= article.getUrl().substring(0, 65)+"..." %></a>
                </article>
        </div>
        <div id="article" class="col-md-6" style="overflow-x:hidden;overflow-y:scroll; height: 1000px; border-right:1px solid #eee;">
                <article class="text-left">
                	<h2 style="color: blue; font-size: 24px ; font-weight: bold"> Tagged Companies</h2>
                	<h3 style="color: black; font-size: 18px ; font-weight: bold"> High Relevance</h3>
					<h4 style="margin-top: 30px;" >
							<%
							for(String tag : article.getHighRelTags()){
							%>
								<p style="margin-top: 15px;"><a href="orgfilter?org=<%= tag.replace("&" , "%26") %>"><span class="label label-default"><%= tag %></span></a></p>
                            <%
                            }
                            %>
					</h4>
					<h3 style="color: black; font-size: 18px ; font-weight: bold ; margin-top: 30px;"> Low Relevance</h3>
					<h4 style="margin-top: 30px;" >
							<%
							for(String tag : article.getLowRelTags()){
							%>
							    <p style="margin-top: 15px;"><a href="orgfilter?org=<%= tag.replace("&" , "%26") %>"><span class="label label-default"><%= tag %></span></a></p>
                            <%
                            	}
                            %>
					 </h4>
                </article>
        </div>
    </div>
    </div>
</div>
</body>
</html>
