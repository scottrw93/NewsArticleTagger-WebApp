<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="newstagger.webapp.tags.Tag" %>
<%@ page import="newstagger.webapp.article.*" %>
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
                    <li><a href="index"> Latest Articles</a></li>
                    <li><a href="orgfilter?org="> Filter by Organisation</a></li>
                </ul>

            </div>

            <!--/.nav-collapse -->
        </div>
    </div>


    <div class="container site-body " align="left" style="margin-top: 30px;">
        <h3 style="color: black; font-size: 18px ; font-weight: bold"> Select Company</h3>

        <select class="form-control" style="margin-top: 20px;" onChange="window.location.href=this.value">

        	<option value="" disabled="disabled" selected="selected">Select Company</option>
<%
/*
		List<String> comps = new ArrayList<String>(entities.keySet());
		Collections.sort(comps);
		for(String n : comps){
%>
    		<option value="filterorgs?org=<%= n %>"><%= n %></option>

<%
		}*/
%>
		</select>


    <div class="col-md-10 col-md-offset-1">
        <div id="update_div">

            <%
                String name = (String) request.getAttribute("name");
                List<Tag> mentions = (List<Tag>) request.getAttribute("mentions");
            %>

                <table class="table table-hover table-striped" style="margin-top: 40px;">
                    <thead>
                    <tr>
                        <th class="col-md-7" style="text-align: center; font-size:20px"><%= name %> Articles

                        </th>
                        <th class="col-md-1" style="text-align: center; font-size:20px">Relevance</th>

                        <th class="col-md-3" style="text-align: center;font-size:20px">Time Published (UTC)</th>
                    </tr>
                    </thead>
                    <tbody>
			<%
				    for(Tag tag : mentions){
                        Article article = tag.getArticle();
			%>
                        <tr>
                            <td><a href="articleview?key=<%= article.getKey() %>"><%= article.getHeadline() %></a></td>
                            <th class="col-md-1" style="text-align: center; font-size:20px"> <%= tag.getRel() %> </th>
                            <td style="text-align: center; vertical-align: middle"> <%= article.getDateAsString() %> </td>
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
