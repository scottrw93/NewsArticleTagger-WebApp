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
					<li class="dropdown"><a href="login.jsp"> Login</a></li>
					<li class="dropdown"><a href="about.jsp"> About Company Tagger</a></li>
                </ul>

            </div>

            <!--/.nav-collapse -->
        </div>
    </div>

    <div class="container site-body " align="center">
        


    <div class="col-md-10 col-md-offset-1">
        <div id="update_div">
            
            
<%
 			
 			ArrayList<String> feeds = new ArrayList<String>();
			
			InputStream is = this.getServletContext().getResourceAsStream("/tagger.properties");
			Properties props = new Properties();
			props.load(is);
			
			String[] list = props.getProperty("rss_feeds").split(",");
			for(String num : list){
				feeds.add(props.getProperty("short.feed"+num));
			}
			
 			for(String feed : feeds){
 			    Filter filterFeed = new FilterPredicate("feed", FilterOperator.EQUAL, feed);
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

				Query query = new Query("Article").setFilter(filterFeed).addSort("date", Query.SortDirection.DESCENDING);
				List<Entity> result = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));

%>

                <table class="table table-hover table-striped" style="margin-top: 40px;">
                    <thead>
                    <tr>
                        <th class="col-md-7" style="text-align: center; font-size:20px">
                        
                        	<a href="filtercategory?feed=<%= feed %>" style="color: black; font-size: 22px ; font-weight: bold"><%= Map.convert(feed) %> Articles</a> 
                            
                        </th>
                        <th class="col-md-1" style="text-align: center; font-size:20px">Tags</th>
                        
                        <th class="col-md-3" style="text-align: center;font-size:20px">Time Published (UTC)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                    	for(Entity article : result){
                    		String key = KeyFactory.keyToString(article.getKey());
							String headline = (String) article.getProperty("headline");
							String summary = (String) article.getProperty("summary");
							String tags = (String) article.getProperty("tags");
							String url = (String) article.getProperty("url");
							Date date = (Date) article.getProperty("date");
							Integer numTags = tags.split("\'[HML]\'").length-1;
                    %>
                        <tr>
                            <td><a href="webapptagger?key=<%= key %>"><%= headline %></a></td>
                            <th class="col-md-1" style="text-align: center; font-size:20px"> <%= numTags %> </th>
                            <td style="text-align: center; vertical-align: middle"> <%= date.toString().replace(" GMT ", " ") %> </td>
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
