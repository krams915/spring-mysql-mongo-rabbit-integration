package org.krams.tutorial.dto;

import java.util.List;

/**
 * A POJO representing a jQgrid's jsonReader property. 
 * This is mainly used as a DTO for the presentation layer.
 * 
 * @see <a href="http://www.trirand.com/jqgridwiki/doku.php?id=wiki:retrieving_data#json_data">JSON Data</a>
 *
 * @author krams at {@link http://krams915@blogspot.com}
 */
public class JqgridTableDto<T extends Object> {

	/**
	 * Current page of the query
	 */
	private String page;
	
	/**
	 * Total pages for the query
	 */
	private String total;
	
	/**
	 * Total number of records for the query
	 */
	private String records;
	
	/**
	 * An array containing the actual data
	 */
	private List<T> rows;

	public JqgridTableDto() {}
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}

	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}

	public String getRecords() {
		return records;
	}
	public void setRecords(String records) {
		this.records = records;
	}
	
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}

}
