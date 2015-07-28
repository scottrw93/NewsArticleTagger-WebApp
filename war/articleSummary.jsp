<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="java.util.List" %>

<%@ page import="ucd.scott.fyp.map.Map" %>
<%@ page import="ucd.scott.format.TextFormater" %>

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
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>

    <div class="container site-body " align="center">

<%
		String key = request.getParameter("key");
		Entity entity = null;
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key realKey = KeyFactory.stringToKey(key);

		try {
			entity = datastore.get(realKey);
		} catch (EntityNotFoundException e) {
			e.printStackTrace();
		}

		String headline = (String) entity.getProperty("headline");
		String url = (String) entity.getProperty("url");
		String tags = (String) entity.getProperty("tags");
		String summary = (String) entity.getProperty("summary");
		String image = (String) entity.getProperty("image");
		Text text = (Text) entity.getProperty("text");
		Date date = (Date) entity.getProperty("date");

		ArrayList<String> lowTags = new ArrayList<String>();
		ArrayList<String> highTags = new ArrayList<String>();

		for(String tag : tags.subSequence(1, tags.length()-1).toString().split("\', ")){
			if(tag.length() > 1){
				tag = tag.trim();

				if(tag.charAt(tag.length()-1) != '\'')
					tag += '\'';

				String org = tag.substring(0, tag.length()-3).trim();
				String rel = tag.substring(tag.length()-3, tag.length()).trim();

				if(rel.equals("'L'")){
					lowTags.add(org);
				}
				else if(rel.equals("'H'")){
					highTags.add(org);
				}
			}
		}

%>

    <header class="page-header">
        <h2><%= headline %><br>
        	<small><%= TextFormater.formatSummary(summary) %></small>
        </h2>
    </header>

    <div class="row" style="border-bottom:1px solid #eee;" float="left">
        <div id="article" class="col-md-6"
             style="overflow-x:hidden;overflow-y:scroll; height: 1000px; border-right:1px solid #eee;">

                <article class="text-left">
                	<h2 style="color: blue; font-size: 24px ; font-weight: bold"> Article</h2>
                    <strong><%= date.toString()%></strong><br>

                    <%
                    if(!image.equals("None")){
                    %>
                    	<img style="margin-top: 30px;" src="<%= image%>" class="img-responsive" alt="Article Image">
                    <%
                    }
                    %>

                    <p style="margin-top: 18px;">

                    	<%= TextFormater.formatArticle(text) %>
                    </p>
                    <br>
					 <a href="<%= url %>"><%= url.substring(0, 65)+"..." %></a>
                </article>
        </div>
        <div id="article" class="col-md-6" style="overflow-x:hidden;overflow-y:scroll; height: 1000px; border-right:1px solid #eee;">

                <article class="text-left">
                	<h2 style="color: blue; font-size: 24px ; font-weight: bold"> Tagged Companies</h2>
                	<h3 style="color: black; font-size: 18px ; font-weight: bold"> High Relevance</h3>
					<h4 style="margin-top: 30px;" >

							<%
							for(String tag : highTags){

							%>
								<p style="margin-top: 15px;"><a href="filterorgs?org=<%= tag %>"><span class="label label-default"><%= tag %></span></a></p>

                            <%
                            }
                            %>

					</h4>

					<h3 style="color: black; font-size: 18px ; font-weight: bold ; margin-top: 30px;"> Low Relevance</h3>
					<h4 style="margin-top: 30px;" >
							<%
								for(String tag : lowTags){

							%>
							<p style="margin-top: 15px;"><a href="filterorgs?org=<%= tag %>"><span class="label label-default"><%= tag %></span></a></p>

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
