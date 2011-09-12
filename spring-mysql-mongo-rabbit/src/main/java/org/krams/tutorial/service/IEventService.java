package org.krams.tutorial.service;

import java.util.List;

import org.krams.tutorial.domain.Event;

/**
 * Service interface for {@link Event}
 * 
 * @author krams at {@link http://krams915@blogspot.com}
 */
public interface IEventService {

	public Event create(Event event);

	public Event read(Long id);

	public List<Event> readAll();

	public Event update(Event event);

	public Event delete(Long id);

}