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

	<!-- JS Imports -->
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-1.5.2.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-ui-1.8.12.custom.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datejs/date.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datatables/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/util/util.js"></script>
	
	<title>Errors</title>
</head>	
<body>

<script type="text/javascript"> 
// Retrieve all records
$(function() {
	$.getRecords('#errorTable', '${rootUrl}error/getall', 
			['_id', 'type', 'signature', 'arguments',  'count', 'dateEncountered'], 
			function() {
					$('#errorTable').dataTable( {
						"bJQueryUI": true,
						"sPaginationType": "full_numbers"
					});
				});
});
</script>

<h4>Errors</h4>
<table id="errorTable">
	<thead>
		<tr>
			<th></th>
			<th>Id</th>
			<th>Type</th>
			<th>Signature</th>
			<th>Arguments</th>
			<th>Count</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

</body>
</html>