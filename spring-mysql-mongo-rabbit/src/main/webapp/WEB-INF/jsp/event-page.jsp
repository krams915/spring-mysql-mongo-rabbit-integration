<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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

	<title>Events</title>
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

<h3 class="title">Events - DataTables Version</h3>
<table id='eventTable'>
 <thead>
  <tr>
   <th></th>
   <th>Id</th>
   <th>Name</th>
   <th>Description</th>
   <th>Participants</th>
   <th>Date</th>
  </tr>
 </thead>
 <tbody>
 </tbody>
</table>

<c:if test="${empty events}">There are currently no events in the list.</c:if>

<div class="control">
	<span><a href="#" id="addLink">Add</a></span>
	<span><a href="#" id="editLink">Edit</a></span>
	<span><a href="#" id="deleteLink">Delete</a></span>
</div>

<jsp:include page="/WEB-INF/jsp/dialogs/addDialog.jsp"/>
<jsp:include page="/WEB-INF/jsp/dialogs/editDialog.jsp"/>
<jsp:include page="/WEB-INF/jsp/dialogs/deleteDialog.jsp"/>
<jsp:include page="/WEB-INF/jsp/dialogs/genericDialog.jsp"/>

<script type="text/javascript"> 
$(function() {
	// Convert links to buttons
	$('#addLink, #editLink, #deleteLink').button();
	
	// Assign a function to addLink
	// Displays a dialog form for adding a new record
	$("#addLink").click(function() { 
		// Show the dialog
		$( "#addDialog" ).dialog({	
			modal: true,
			width: 350,
			close: function(event, ui) { }
		});
		return false;
	});
	
	// Assign a function to editLink
	// Checks first if a record is selected from the table
	// Then it retrieves that record via jQuery's data()storage method
	// Finally it displays a dialog form for editing the selected record
	$("#editLink").click(function() { 
		var tId = $('input:radio[name=eventRadio]:checked').val();
		if (tId == null) {
			$("#genericDialog").text("Select a record first!");
			$("#genericDialog").dialog( 
					{	title: 'Error',
						modal: true,
						buttons: {"Ok": function()  {
							$(this).dialog("close");} 
						}
					});
		} else {
			// Retrieve record
			var record = null;
			for (var i=0; i<$('#eventTable').data('records').length; i++) {
				if ($('#eventTable').data('records')[i].id == tId) {
					record = $('#eventTable').data('records')[i];
					break;
				}
			}
			
			// Assign record to form fields
			$('#editForm #ename').val(record.name.toString());
			$('#editForm #edate').val(new Date(record.date).toString('yyyy-MM-dd'));
			$('#editForm #edescription').val(record.description.toString());
			$('#editForm #eparticipants').val(record.participants.toString());

			// Show the dialog
			$("#editDialog").dialog({	
				modal: true,
				width: 350,
				close: function(event, ui) { }
			});
		}
		return false;
	});

	// Assign a function to deleteLink
	// Checks first if a record is selected from the table
	// Finally it displays a dialog form for deleting the selected record
	$("#deleteLink").click(function() { 
		// show dialog box
		var tId = $('input:radio[name=eventRadio]:checked').val();
		if (tId == null) {
			$("#genericDialog").text("Select a record first!");
			$("#genericDialog").dialog( 
					{	title: 'Error',
						modal: true,
						buttons: {"Ok": function()  {
							$(this).dialog("close");} 
						}
					});
		} else {
			$("#deleteDialog").dialog({	
				modal: true,
				width: 350,
				close: function(event, ui) { }
			});
		}
		return false;
	});
	
	// Retrieve all records for the first time
	// Converts table to DataTable as well
	$.getRecords('#eventTable', '${rootUrl}event/getall', 
			['id', 'name', 'description', 'participants', 'date'], 
			function() {
				$('#eventTable').dataTable( {
					"bJQueryUI": true,
					"sPaginationType": "full_numbers"
				});
		});
});
</script>

</body>
</html>