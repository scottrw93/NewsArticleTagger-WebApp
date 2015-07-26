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
<%@ page import="java.util.Calendar" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="ucd.scott.fyp.stucture.LowHighTagCounter" %>
<%@ page import="ucd.scott.fyp.stucture.ValueComparator" %>

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
		String parameter = request.getParameter("time_period");
		Integer time_per =  parameter == null ? 12 : Integer.parseInt(parameter);
		String message = time_per == 100 ? "All Articles Selected" 
											: "Articles published in last "+time_per+" hour(s) selected";
			
	%>

	
    <div class="container site-body " align="left" style="margin-top: 30px;">
	
        <h3 style="color: black; font-size: 18px ; font-weight: bold"> Select Time Period</h3>
        
        <select name= "time_period" class="form-control" style="margin-top: 20px;" onchange="window.location.href=this.value">
        	<option value="" disabled="disabled" selected="selected"><%= message %></option>
    		<option value="mostTagged.jsp?time_period=1"><%= "1 Hours" %></option>
    		<option value="mostTagged.jsp?time_period=6"><%= "6 Hours" %></option>
    		<option value="mostTagged.jsp?time_period=12"><%= "12 Hours" %></option>
    		<option value="mostTagged.jsp?time_period=24"><%= "24 Hours" %></option>
    		<option value="mostTagged.jsp?time_period=100"><%= "All Articles" %></option>
		</select>
	


    <div class="col-md-10 col-md-offset-1">
        <div id="update_div">
            
            
<%
		
 		Date dateInstance = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateInstance);
		cal.add(Calendar.HOUR, -time_per);
		Date date = cal.getTime();

		Filter olderThan =  new FilterPredicate("date", FilterOperator.GREATER_THAN, date);		
					
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Article").addSort("date", Query.SortDirection.DESCENDING).setFilter(olderThan);
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
					if(rel.equals("'L'")){
						entities.get(org).incrLow();
					}
					else if(rel.equals("'H'")){
						entities.get(org).incrHigh();
					}
				}
			}
		}
		ValueComparator bvc =  new ValueComparator(entities);
		TreeMap<String, LowHighTagCounter>  sorted_map = new TreeMap<String, LowHighTagCounter> (bvc);

		sorted_map.putAll(entities);
%>



                <table class="table table-hover table-striped" style="margin-top: 40px;">
                    <thead>
                    <tr>
                        <th class="col-md-7" style="text-align: center; font-size:20px">
                        
                        	<a href="#" style="color: black; font-size: 22px ; font-weight: bold">Most Tagged Companies</a> 
                            
                        </th>
                        <th class="col-md-3" style="text-align: center; font-size:20px"> High Tags</th>
                        
                        <th class="col-md-3" style="text-align: center; font-size:20px"> Low Tags</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                    for(String org : sorted_map.keySet()){	
                    		LowHighTagCounter pair = entities.get(org);
                    %>
                        <tr>
                            <td><a href="filterorgs?org=<%= org %>"><%= org %></a></td>
                            <th class="col-md-1" style="text-align: center; font-size:20px"> <%= pair.getHighCount() %> </th>
                            <th class="col-md-1" style="text-align: center; font-size:20px"> <%= pair.getLowCount() %> </th>
                        </tr>    
                        
<%
					}
%>                                 
                    </tbody>
                </table>  
                
            
        </div>
    </div>
</div>
</body>

</html>
