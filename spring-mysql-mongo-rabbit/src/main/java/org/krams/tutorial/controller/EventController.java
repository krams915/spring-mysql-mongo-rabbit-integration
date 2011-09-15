package org.krams.tutorial.controller;

import java.util.List;
import org.krams.tutorial.domain.Event;
import org.krams.tutorial.dto.ResponseDto;
import org.krams.tutorial.service.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controlling for handling event requests
 * 
 * @author krams at {@link http://krams915@blogspot.com}
 */
@Controller
@RequestMapping("/event")
public class EventController {
	
	@Autowired
	private volatile IEventService service;

	@RequestMapping
	public String getEventPage() {
		return "event-page";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public @ResponseBody ResponseDto<Event> add(Event event) {
		
		if (service.create(event) != null) {
			return new ResponseDto<Event>(true);
		}
		
		return new ResponseDto<Event>(false);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public @ResponseBody ResponseDto<Event> edit(Event event) {
		
		if (service.update(event) != null) {
			return new ResponseDto<Event>(true);
		}

		return new ResponseDto<Event>(false);
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody ResponseDto<Event> delete(Long id) {
		
		if (service.delete(id) == null) {
			return new ResponseDto<Event>(true);
		}
	
		return new ResponseDto<Event>(false);
	}
	
	@RequestMapping(value = "/getall", method = RequestMethod.POST)
	public @ResponseBody ResponseDto<Event> getall() {

		List<Event> events = service.readAll();
		
		if (events != null) {
			return new ResponseDto<Event>(true, events);
		}

		return new ResponseDto<Event>(false);
	}
}
