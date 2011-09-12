/**
 * jQuery Utility Plugin
 */
(function($){ 
	$.extend({  
		// Retrieves records and passes the records to populateTable function
		getRecords: function(tableId, url, fields, afterFunction) {
			$.post(url,
				function(result){
					if (result.success == true) {
						// Store original data to table for latter reference
						$(tableId).data('records', result.messages);
						// Populate table
						$.populateTable(result.messages, tableId, fields, afterFunction);
					} else {
						console.log("failure");
					}
			});
		},

		// Populates table body with data
		populateTable: function(data, tableId, fields, afterFunction) {
			// Empty contents of table to ensure old data doesn't show
			$(tableId + ' tbody').empty();
			
			var tableBody = [];
			var i = 0;
			var length = data.length;
			var fieldsLength = fields.length;
			for (var a = 0; a <length; a += 1) {
			    tableBody[i++] = '<tr>';
			    
			    tableBody[i++] = '<td>';
			    tableBody[i++] = '<input type="radio" name="eventRadio" value="';
			    tableBody[i++] = data[a].id;
			    tableBody[i++] = '" />';
			    tableBody[i++] = '</td>';
			    
			    for (var f = 0; f < fieldsLength; f++) {
				    tableBody[i++] = '<td>';
				    tableBody[i++] = eval('data[a].' + fields[f]);
				    tableBody[i++] = '</td>';
			    }
			    
			    tableBody[i++] = '</tr>' ;
			}

			// Combine tableBody's elements and append to table
			$(tableId).append(tableBody.join(''));
			
			// Run after hook
			if (afterFunction != null) {
				afterFunction();
			}
		} 
	}); 
	
	$.extend(
		    $.expr[':'], {
		        regex: function(a, i, m, r) {
		            var r = new RegExp(m[3], 'i');
		            return r.test($(a).text());
		        }
		    }
		);
})(jQuery);
