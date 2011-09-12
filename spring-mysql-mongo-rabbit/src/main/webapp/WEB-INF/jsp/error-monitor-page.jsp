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
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/jquery/pepper-grinder/jquery-ui-1.8.12.custom.css"/>

	<!-- JS Imports -->
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-1.5.2.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-ui-1.8.12.custom.min.js"></script>

	<title>Demo</title>
</head>	
<body>

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

<h4>Error Monitor</h4>
<div id="log" style="border : solid 2px #cccccc; background : #000000; color : #ffffff; padding : 4px; height : 300px; overflow : auto;"> </div>

</body>
</html>