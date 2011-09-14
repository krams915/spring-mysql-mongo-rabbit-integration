<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page session="false" %>

<c:url value="/" var="rootUrl"/>
<c:url value="/resources" var="resourcesUrl"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<!-- CSS Imports-->
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/jquery/dark-hive/jquery-ui-1.8.6.custom.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/datatables/custom.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/main/main.css"/>
	
	<!-- JS Imports -->
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-1.5.2.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-ui-1.8.12.custom.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datejs/date.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datatables/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/util/util.js"></script>
	
	<title>Errors</title>
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

<h3 class="title">Errors</h3>
<table id="errorTable">
	<thead>
		<tr>
			<th></th>
			<th>Type</th>
			<th>Arguments</th>
			<th>Count</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script type="text/javascript"> 
// Retrieves all records
$(function() {
	$.getRecords('#errorTable', '${rootUrl}error/getall', 
		['type', 'arguments',  'count', 'dateEncountered'], 
		function() {
			$('#errorTable').dataTable( {
				"bJQueryUI": true,
				"sPaginationType": "full_numbers"
			});
		});
});
</script>

</body>
</html>