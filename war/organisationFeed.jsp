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

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="ucd.scott.fyp.stucture.LowHighTagCounter" %>
<%@ page import="ucd.scott.fyp.stucture.ValueComparator" %>
<%@ page import="java.util.Collections" %>


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
                    <li><a href="index.jsp"> Latest Articles</a></li>
                    <li><a href="filtermosttagged">Trending Companies</a></li>
                    <li><a href="newsFeed.jsp?feed=technologyNews"> Filter By Category</a></li>
					<li><a href="organisationFeed.jsp?org="> Filter By Company</a></li>
					<li><a href="about.jsp"> About Company Tagger</a></li>
                </ul>

            </div>

            <!--/.nav-collapse -->
        </div>
    </div>
    
    <%
 			
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Article").addSort("date", Query.SortDirection.DESCENDING);
		PreparedQuery result = datastore.prepare(query);

		HashMap<String, LowHighTagCounter> entities = new HashMap<String, LowHighTagCounter>();

		for(Entity entity : result.asIterable()){
			String tags = (String) entity.getProperty("tags");

			for(String tag : tags.subSequence(1, tags.length()-1).toString().split("\', ")){
				if(tag.length() > 1){
					tag = tag.trim();

					if(tag.charAt(tag.length()-1) != '\'') 
						tag += '\'';

					String org = tag.substring(0, tag.length()-3).trim();
					String rel = tag.substring(tag.length()-3, tag.length()).trim();
					if(!entities.containsKey(org)){
						entities.put(org, new LowHighTagCounter());
					}
				}
			}
		}
%>

    <div class="container site-body " align="left" style="margin-top: 30px;">
        <h3 style="color: black; font-size: 18px ; font-weight: bold"> Select Company</h3>
        
        <select class="form-control" style="margin-top: 20px;" onChange="window.location.href=this.value">
        
        	<option value="" disabled="disabled" selected="selected">Select Company</option>
<%
		ArrayList<String> comps = new ArrayList<String>(entities.keySet());
		Collections.sort(comps);
		for(String n : comps){
%>
    		<option value="filterorgs?org=<%= n %>"><%= n %></option>

<%
		}
%>
		</select>


    <div class="col-md-10 col-md-offset-1">
        <div id="update_div">
            
            
<%
	String name = request.getParameter("org");
	
	query = new Query("Article").addSort("date", Query.SortDirection.DESCENDING);
	result = datastore.prepare(query);
	
	List<Entity> entitie = new ArrayList<Entity>();
	
	for(Entity entity : result.asIterable()){
			String tags = (String) entity.getProperty("tags");

			for(String tag : tags.subSequence(1, tags.length()-1).toString().split("\', ")){
				if(tag.length() > 1){
					tag = tag.trim();

					if(tag.charAt(tag.length()-1) != '\'') 
						tag += '\'';

					String org = tag.substring(0, tag.length()-3).trim();
					if(org.equals(name)){
						if(!entitie.contains(entity))
							entitie.add(entity);
					}
				}
			}
	}

%>

                <table class="table table-hover table-striped" style="margin-top: 40px;">
                    <thead>
                    <tr>
                        <th class="col-md-7" style="text-align: center; font-size:20px"><%= name %> Articles 
                            
                        </th>
                        <th class="col-md-1" style="text-align: center; font-size:20px">Tags</th>
                        
                        <th class="col-md-3" style="text-align: center;font-size:20px">Time Published (UTC)</th>
                    </tr>
                    </thead>
                    <tbody>
			<%
				    for(Entity article : entitie){
						String headline = (String) article.getProperty("headline");
						String summary = (String) article.getProperty("summary");
						String tags = (String) article.getProperty("tags");
						String url = (String) article.getProperty("url");
						Date date = (Date) article.getProperty("date");
						Integer numTags = tags.split("\'[HML]\'").length-1;
						String key = KeyFactory.keyToString(article.getKey());
			%>
                        <tr>
                            <td><a href="webapptagger?key=<%= key %>"><%= headline %></a></td>
                            <th class="col-md-1" style="text-align: center; font-size:20px"> <%= numTags %> </th>
                            <td style="text-align: center; vertical-align: middle"> <%= date.toString().replace(" GMT ", " ") %> </td>
                        </tr>              
 
            <%}%>    
                    </tbody>
                </table>            
        </div>
    </div>
</div>

</body>

</html>
