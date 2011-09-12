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

	<!-- JS Imports -->
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-1.5.2.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-ui-1.8.12.custom.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datejs/date.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datatables/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/util/util.js"></script>

	<title>Events</title>
</head>	
<body class="ui-widget-content">

<script type="text/javascript"> 
	$(function() {
		// Buttonize links
		$('#button a').button();
		$('input:submit, #addCancel, #editCancel').button();
		
		// convert date text input to jquery dates
		$("#date").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd'
		});
		
		// convert date text input to jquery dates
		$("#edate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd'
		});
		
		$("#addLink").click(function() { 
				// show dialog box
				$( "#addDialog" ).dialog({	
					modal: true,
					width: 350,
					close: function(event, ui) { }
				});
			return false;
		});
		
		$('#addCancel').click(function() { 
			$('#addDialog').dialog("close");
		});
		
		$("#addForm").submit(function() { 
			$.post("${rootUrl}event/add",  
				{name: $('#addForm #name').val(),
				date: new Date($('#addForm #date').val()).toISOString(),
				description: $('#addForm #description').val(),
				participants: $('#addForm #participants').val()},
				function(result){
					// close parent dialog
					$("#addDialog").dialog("close"); 
					
					if (result.success == true) {
						$("#genericDialog").text("New event saved.");
						$("#genericDialog").dialog( 
								{	title: 'Success',
									modal: true,
									buttons: {"Ok": function()  {
										$("#genericDialog").dialog("close");} 
									}
								});
						getRecords();
					} else {
						$("#genericDialog").text("Unable to save new event!");
						$("#genericDialog").dialog( 
								{	title: 'Error',
									modal: true,
									buttons: {"Ok": function()  {
										$("#genericDialog").dialog("close");} 
									}
								});

					}
			});
			return false;
		});
		
		$("#editLink").click(function() { 
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
				// Populate form with selected record data
				var record = null;
				for (var i=0; i<$('#eventTable').data('records').length; i++) {
					if ($('#eventTable').data('records')[i].id == tId) {
						record = $('#eventTable').data('records')[i];
						break;
					}
				}
				
				$('#editForm #name').val(record.name.toString());
				$('#editForm #edate').val(new Date(record.date).toString('yyyy-MM-dd'));
				$('#editForm #description').val(record.description.toString());
				$('#editForm #participants').val(record.participants.toString());
				
				$("#editDialog").dialog({	
					modal: true,
					width: 350,
					close: function(event, ui) { }
				});
			}
		return false;
		});
		
		$('#editCancel').click(function() { 
			$('#editDialog').dialog("close");
		});
		
		$("#editForm").submit(function() { 
			$.post("${rootUrl}event/edit", { 
				id:  $('input:radio[name=eventRadio]:checked').val(), 
				name: $('#editForm #name').val(),
				date: new Date($('#editForm #edate').val()).toISOString(),
				description: $('#editForm #description').val(),
				participants: $('#editForm #participants').val()},
				function(result){
					// close parent dialog
					$("#editDialog").dialog("close"); 
					
					if (result.success == true) {
						$("#genericDialog").text("Updated event saved");
						$("#genericDialog").dialog( 
								{	title: 'Success',
									modal: true,
									buttons: {"Ok": function()  {
										$("#genericDialog").dialog("close");} 
									}
								});
						getRecords();
					} else {
						$("#genericDialog").text("Unable to update event!");
						$("#genericDialog").dialog( 
								{	title: 'Error',
									modal: true,
									buttons: {"Ok": function()  {
										$("#genericDialog").dialog("close");} 
									}
								});

					}
			});
			return false;
		});
		
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
				$("#deleteDialog").text("Do you want to delete event " + tId + " ?");
				$("#deleteDialog").dialog({	
					modal: true,
					width: 350,
					close: function(event, ui) { },
					buttons: {
						"Yes": function()  {
							$.post("${rootUrl}event/delete", { 
								id:  tId},
								function(result){
									// close parent dialog
									$("#deleteDialog").dialog("close"); 
									
									if (result.success == true) {
										$("#genericDialog").text("Event has been deleted");
										$("#genericDialog").dialog( 
												{	title: 'Success',
													modal: true,
													buttons: {"Ok": function()  {
														$(this).dialog("close");} 
													}
												});
										getRecords();
									} else {
										$("#genericDialog").text("Unable to update event!");
										$("#genericDialog").dialog( 
												{	title: 'Error',
													modal: true,
													buttons: {"Ok": function()  {
														$(this).dialog("close");} 
													}
												});
	
									}
							});
						}, // End of Yes function
						"Cancel": function()  {
							$(this).dialog("close");
						}  // End of Cancel function
					}
				});
			}
		return false;
		});
	});
</script>

<script type="text/javascript"> 
// Retrieve all records
$(function() {
	$.getRecords('#eventTable', '${rootUrl}event/getall', 
			['id', 'name', 'description', 'participants'], 
			function() {
					$('#eventTable').dataTable( {
						"bJQueryUI": true,
						"sPaginationType": "full_numbers"
					});
				});
});
</script>

<h4>Events</h4>
<table id='eventTable' style="border: 1px solid; width: 100%; text-align:center">
 <thead style="background:#fcf">
  <tr>
   <th></th>
   <th>Id</th>
   <th>Name</th>
   <th>Description</th>
   <th>Participants</th>
  </tr>
 </thead>
 <tbody>
 </tbody>
</table>

<span id="button"><a href="#" id="addLink">Add</a></span>
<span id="button"><a href="#" id="editLink">Edit</a></span>
<span id="button"><a href="#" id="deleteLink">Delete</a></span>

<c:if test="${empty events}">There are currently no events in the list.</c:if>
	
<jsp:include page="/WEB-INF/jsp/dialogs/addDialog.jsp"/>
<jsp:include page="/WEB-INF/jsp/dialogs/editDialog.jsp"/>
<jsp:include page="/WEB-INF/jsp/dialogs/deleteDialog.jsp"/>
<jsp:include page="/WEB-INF/jsp/dialogs/genericDialog.jsp"/>

</body>
</html>
