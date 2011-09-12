package org.krams.tutorial.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

/**
 * A simple Event class.
 * 
 * @author krams at {@link http://krams915@blogspot.com}
 */
@Entity
public class Event {

	@Id
	@GeneratedValue
	private Long id;
	
	@NotNull(message="Name: Please enter name of event")
	private String name;
	
	private String description;

	@NotNull(message="Participants: Please enter number of participants")
	private Integer participants;
	
	@NotNull(message="Date: Please enter a date")
	@DateTimeFormat(iso=ISO.DATE_TIME)
	private Date date;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}	
	public Integer getParticipants() {
		return participants;
	}
	public void setParticipants(Integer participants) {
		this.participants = participants;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Event [id=" + id + ", name=" + name + ", description="
				+ description + ", participants=" + participants + ", date="
				+ date + "]";
	}
}
