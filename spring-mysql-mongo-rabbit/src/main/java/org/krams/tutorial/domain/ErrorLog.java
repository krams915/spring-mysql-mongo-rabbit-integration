package org.krams.tutorial.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.data.annotation.Id;

import org.springframework.data.mongodb.core.mapping.Document;

/**
 * Represents an error log entity
 * 
 * @author krams at {@link http://krams915@blogspot.com}
 */
@Document
public class ErrorLog implements Serializable {

	private static final long serialVersionUID = 1326887243102331826L;
	
	@Id
	private String id;
	
	private String type;
	private String message;
	private String signature;
	private String arguments;
	private int count;
	private Date dateEncountered;

	public ErrorLog() {
		super();
	}
	
	public ErrorLog(String type, String message, Date dateEncountered) {
		super();
		this.type = type;
		this.message = message;
		this.count = 1;
		this.dateEncountered = dateEncountered;
	}
	
	public ErrorLog(String type, String message, Date dateEncountered, String signature, String arguments) {
		super();
		this.type = type;
		this.message = message;
		this.count = 1;
		this.dateEncountered = dateEncountered;
		this.signature = signature;
		this.arguments = arguments;
	}
	
	public ErrorLog(String type, String message, int count,
			Date dateEncountered) {
		super();
		this.type = type;
		this.message = message;
		this.count = count;
		this.dateEncountered = dateEncountered;
	}

	public ErrorLog(String type, String message, int count,
			Date dateEncountered, String signature, String arguments) {
		super();
		this.type = type;
		this.message = message;
		this.count = count;
		this.dateEncountered = dateEncountered;
		this.signature = signature;
		this.arguments = arguments;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getArguments() {
		return arguments;
	}

	public void setArguments(String arguments) {
		this.arguments = arguments;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getDateEncountered() {
		return dateEncountered;
	}

	public void setDateEncountered(Date dateEncountered) {
		this.dateEncountered = dateEncountered;
	}

	@Override
	public String toString() {
		return "Error [id=" + id + ", type=" + type + ", message=" + message
				+ ", signature=" + signature + ", arguments=" + arguments
				+ ", count=" + count + ", dateEncountered=" + dateEncountered
				+ "]";
	}
}
