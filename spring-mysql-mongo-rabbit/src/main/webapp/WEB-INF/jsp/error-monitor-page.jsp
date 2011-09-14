<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page session="false" %>

<c:url value="/" var="rootUrl"/>
<c:url value="/resources" var="resourcesUrl"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<!-- CSS Imports-->
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/jquery/dark-hive/jquery-ui-1.8.6.custom.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/main/main.css"/>
	
	<!-- JS Imports -->
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-1.5.2.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-ui-1.8.12.custom.min.js"></script>

	<title>Error Monitor</title>
</head>	
<body class="ui-widget-content">

<div id="menu">
	<ul>
	<li><a href="${rootUrl}event">Events (DataTables)</a></li>
	<li><a href="${rootUrl}jqgrid/event">Events (jQgrid)</a></li>
	<li><a href="${rootUrl}error">Errors</a></li>
	<li><a href="${rootUrl}monitor/event">Monitor Events</a></li>
	<li><a href="${rootUrl}monitor/error">Monitor Errors</a></li>
	</ul>
	<br style="clear:left"/>
</div>

<script type="text/javascript">
	var running = false;
	var timer;
	function load() {
		if (running) {
			$.ajax({
				url : '${rootUrl}monitor/error/log',
				success : function(message) {
					if (message && message.length) {
						var messagesDiv = $('#log');
						messagesDiv.html(message);
						messagesDiv.animate({ scrollTop: messagesDiv.attr("scrollHeight") - messagesDiv.height() }, 150);
					}
					timer = poll();
				},
				error : function() {
					timer = poll();
				},
				cache : false
			});
		}
	}
	function start() {
		if (!running) {
			running = true;
			if (timer != null) {
				clearTimeout(timer);
			}
			timer = poll();
		}
	}
	function poll() {
		if (timer != null) {
			clearTimeout(timer);
		}
		return setTimeout(load, 1000);
	}
	$(function() {
		start();
	});
</script>

<h3 class="title">Error Monitor</h3>
<div id="log" class="monitor"> </div>

</body>
</html>