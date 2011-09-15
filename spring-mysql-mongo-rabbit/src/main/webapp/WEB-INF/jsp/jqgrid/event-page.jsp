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
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/jqgrid/ui.jqgrid.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="${resourcesUrl}/css/main/main.css"/>
	
	<!-- JS Imports -->
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-1.5.2.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jquery/jquery-ui-1.8.12.custom.min.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/datejs/date.js"></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jqgrid/grid.locale-en.js" ></script>
	<script type="text/javascript" src="${resourcesUrl}/js/jqgrid/jquery.jqGrid.min.js"></script>
	
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

<h3 class="title">Events - jQgrid Version</h3>
<div id="jqgrid">
	<table id="grid"></table>
	<div id="pager"></div>
</div>

<script type="text/javascript"> 
$(function() {
	$("#grid").jqGrid({
	   	url:'${rootUrl}jqgrid/event/getall',
		datatype: 'json',
		mtype: 'POST',
	   	colNames:['Id',
	  		   	'Name', 
	  		   	'Description', 
	  		   	'Participants', 
	  		   	'Date'],
	   	colModel:[
	   		{name:'id',index:'id', width:55, editable:false},
	   		{name:'name',index:'name', width:90, editable:true},
	   		{name:'description',index:'description', width:90, editable:true},
	   		{name:'participants',index:'participants', width:50, editable:true},
	   		{name:'date',index:'date', width:90, editable:false, formatter:'date', formatoptions:{newformat: 'd/M/Y'}, editable:true}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	autowidth: true,
		rownumbers: true,
	   	pager: '#pager',
	   	sortname: 'id',
	    viewrecords: true,
	    sortorder: "asc",
	    caption:"Events",
	    emptyrecords: "Empty records",
	    loadonce: false,
	    jsonReader : {
	        root: "rows",
	        page: "page",
	        total: "total",
	        records: "records",
	        repeatitems: false,
	        cell: "cell",
	        id: "id"
	    }
	});
	
	$("#grid").jqGrid('navGrid','#pager',
			{edit:false,add:false,del:false,search:true},
			{ },
	        { },
	        { }, 
	        { 
	        	sopt:['eq', 'ne', 'lt', 'gt', 'cn', 'bw', 'ew'],
		        closeOnEscape: true, 
		        	multipleSearch: true, 
		         	closeAfterSearch: true }
	);

	$("#grid").navButtonAdd('#pager',
			{ 	caption:"Add", 
				buttonicon:"ui-icon-plus", 
				onClickButton: addRow,
				position: "last", 
				title:"", 
				cursor: "pointer"
			} 
	);
	
	$("#grid").navButtonAdd('#pager',
			{ 	caption:"Edit", 
				buttonicon:"ui-icon-pencil", 
				onClickButton: editRow,
				position: "last", 
				title:"", 
				cursor: "pointer"
			} 
	);
	
	$("#grid").navButtonAdd('#pager',
		{ 	caption:"Delete", 
			buttonicon:"ui-icon-trash", 
			onClickButton: deleteRow,
			position: "last", 
			title:"", 
			cursor: "pointer"
		} 
	);
});

function addRow() {
	// Get the currently selected row
    $("#grid").jqGrid('editGridRow','new',
    		{ 	url: "${rootUrl}jqgrid/event/add", 
                serializeEditData: function(data){ 
                    data.id = 0; 
	                data.date = new Date(data.date).toISOString();
                    return $.param(data);
                },
			    recreateForm: true,
				closeAfterAdd: true,
				reloadAfterSubmit:true,
				beforeShowForm: function(form) {
			    	$("#date").datepicker({
						changeMonth: true,
						changeYear: true
					});
				},
				afterSubmit : function(response, postdata) 
				{ 
			        var result = eval('(' + response.responseText + ')');
					var errors = "";
					
			        if (result.success == false) {
						for (var i = 0; i < result.message.length; i++) {
							errors +=  result.message[i] + "<br/>";
						}
			        }  else {
			        	$("#dialog").text('Entry has been added successfully');
						$("#dialog").dialog( 
								{	title: 'Success',
									modal: true,
									buttons: {"Ok": function()  {
										$(this).dialog("close");} 
									}
								});
	                }
			    	// only used for adding new records
			    	var new_id = null;
			    	
					return [result.success, errors, new_id];
				}
    		});
}

function editRow() {
	// Get the currently selected row
	var row = $("#grid").jqGrid('getGridParam','selrow');
	
	if( row != null ) 
		$("#grid").jqGrid('editGridRow',row,
			{	url: "${rootUrl}jqgrid/event/edit",
	            serializeEditData: function(data){ 
	                data.date = new Date(data.date).toISOString();
	                return $.param(data);
	            },
		        recreateForm: true,
				closeAfterEdit: true,
				reloadAfterSubmit:true,
			    beforeShowForm: function(form) {
			    	$("#date").datepicker({
						changeMonth: true,
						changeYear: true
					});
				},
				afterSubmit : function(response, postdata) 
				{ 
		            var result = eval('(' + response.responseText + ')');
					var errors = "";
					
		            if (result.success == false) {
						for (var i = 0; i < result.message.length; i++) {
							errors +=  result.message[i] + "<br/>";
						}
		            }  else {
		            	$("#dialog").text('Entry has been edited successfully');
						$("#dialog").dialog( 
								{	title: 'Success',
									modal: true,
									buttons: {"Ok": function()  {
										$(this).dialog("close");} 
									}
								});
	                }
		        	
					return [result.success, errors, null];
				}
			});
	else alert("Please select row");
}

function deleteRow() {
	// Get the currently selected row
    var row = $("#grid").jqGrid('getGridParam','selrow');

    // A pop-up dialog will appear to confirm the selected action
	if( row != null ) 
		$("#grid").jqGrid( 'delGridRow', row,
          	{ url: '${rootUrl}jqgrid/event/delete', 
						recreateForm: true,
			            beforeShowForm: function(form) {
			              //change title
			              $(".delmsg").replaceWith('<span style="white-space: pre;">' +
			            		  'Delete selected record?' + '</span>');
	            		  
						  //hide arrows
			              $('#pData').hide();  
			              $('#nData').hide();  
			            },
          				reloadAfterSubmit:false,
          				closeAfterDelete: true,
          				afterSubmit : function(response, postdata) 
						{ 
			                var result = eval('(' + response.responseText + ')');
							var errors = "";
							
			                if (result.success == false) {
								for (var i = 0; i < result.message.length; i++) {
									errors +=  result.message[i] + "<br/>";
								}
			                }  else {
			                	$("#dialog").text('Entry has been deleted successfully');
								$("#dialog").dialog( 
										{	title: 'Success',
											modal: true,
											buttons: {"Ok": function()  {
												$(this).dialog("close");} 
											}
										});
			                }
		                	// only used for adding new records
		                	var new_id = null;
		                	
							return [result.success, errors, new_id];
						}
          	});
	else alert("Please select row");
}

</script>

<div id="dialog" title="Feature not supported" style="display:none">
	<p>That feature is not supported.</p>
</div>

</body>
</html>
