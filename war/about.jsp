<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="java.util.List" %>

<%@ page import="ucd.scott.fyp.map.Map" %>

<%@ page import="java.io.IOException" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.io.InputStream" %>

<%@ page import="com.google.appengine.api.datastore.*" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilter" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator" %>

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
                    <li class="dropdown"><a href="index.jsp"> Latest Articles</a></li>
                    <li class="dropdown"><a href="filtermosttagged"> Trending Companies</a></li>
                    <li class="dropdown"><a href="newsFeed.jsp?feed=technologyNews"> Filter By Category</a></li>
					<li class="dropdown"><a href="organisationFeed.jsp?org="> Filter By Company</a></li>
					<li class="dropdown"><a href="about.jsp"> About Company Tagger</a></li>
                </ul>

            </div>

            <!--/.nav-collapse -->
        </div>
    </div>

    <div class="container site-body " align="center">
        


    <div class="col-md-10 col-md-offset-1">
        <div id="update_div">
        <h2 style="text-align: left; margin-top: 30px;">About Company Tagger</h2>
           <p style="text-align: left; margin-top: 30px;">
           
           Developed by Scott Williams, a 4th year UCD student, this is a Final Year Computer<br> Science Project.
           Company Tagger implements a new approach to Named Entity Recognition <br>by focusing
           on detecting specific companies and organisations from a known list. It also rates<br> the
           relevance of companies to the article where they are found to avoid information overload.<br> The idea
           for this came from a Data challenge proposed by Thomson Reuters, available
           <br>to view <a href="https://www.innocentive.com/ar/challenge/9933333">here</a>.
           <br><br>
           Articles are sourced from Thomson Reuters Rss Feeds.
           </p> 
           
        <h2 style="text-align: left; margin-top: 30px;">About Scott Williams</h2>
           <p style="text-align: left; margin-top: 30px;">
           
           I am a final year Computer Science student in UCD. I have experience with a number of programming<br> languages,
           mostly working in Java, Python and Ruby with some C/C++. I am a keen programmer,
           and<br> regularly complete puzzles at <a href="http://programmingpraxis.com/">Programming Praxis</a>.
           <br><br>
           I have a Github account available <a href="https://github.com/scottrw93/">here</a> and you can find
           out more about me on my <a href="http://ie.linkedin.com/pub/scott-williams/64/a74/27a"> Linked In</a>  page.

           </p>
        </div>

    </div>
</div>

</body>

</html>
