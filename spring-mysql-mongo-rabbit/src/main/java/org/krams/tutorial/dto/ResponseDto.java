package org.krams.tutorial.dto;

import java.util.List;

/**
 * A generic dto for sending responses from controllers.
 * Depending on the content-type, the response will be
 * converted either as JSON or XML or in another format.
 * 
 * @param <T> the domain class to be transferred
 */
public class ResponseDto<T extends Object> {

	protected Boolean success;
	protected List<T> messages;
	
	public ResponseDto(Boolean success) {
		super();
		this.success = success;
	}
	
	public ResponseDto(Boolean success, List<T> messages) {
		super();
		this.success = success;
		this.messages = messages;
	}
	
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public List<T> getMessages() {
		return messages;
	}
	public void setMessagse(List<T> messages) {
		this.messages = messages;
	}
}
