<div id="addDialog" title="Add a new event" style="display:none">
	<form id="addForm">
		<table>
			<thead>
				<tr><th></th><th></th></tr>
			</thead>
			<tbody>
				<tr><td>Name:</td><td><input type="text" id="aname" name="aname"/></td></tr>
				<tr><td>Date:</td><td><input type="text" id="adate" name="adate"/></td></tr>
				<tr><td>Description:</td><td><input type="text" id="adescription" name="adescription"/></td></tr>
				<tr><td>Participants:</td><td><input type="text" id="aparticipants" name="aparticipants"/></td></tr>
				<tr><td></td>
					<td>
						<input type="submit" value="Save" />
						<input id="addCancel" type="button" value="Cancel" />
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<script type="text/javascript">
$(function() {
	// Convert links to buttons
	$('input:submit, #addCancel').button();
	
	//Convert text input to jQuery DatePicker
	// This helps us add date entries to text inputs
	$("#adate").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy-mm-dd'
	});
});

$('#addCancel').click(function() { 
	$('#addDialog').dialog("close");
});

$("#addForm").submit(function() { 
	$.post("${rootUrl}event/add",  
		{name: $('#addForm #aname').val(),
		date: new Date($('#addForm #adate').val()).toISOString(),
		description: $('#addForm #adescription').val(),
		participants: $('#addForm #aparticipants').val()},
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

				// retrieve all records
				$.getRecords('#eventTable', '${rootUrl}event/getall', 
						['id', 'name', 'description', 'participants'], 
						null);
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
</script>