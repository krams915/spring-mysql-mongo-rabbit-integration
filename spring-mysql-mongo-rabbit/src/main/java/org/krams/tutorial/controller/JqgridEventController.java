package org.krams.tutorial.controller;

import java.util.List;
import org.krams.tutorial.domain.Event;
import org.krams.tutorial.dto.JqgridTableDto;
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
@RequestMapping("/jqgrid/event")
public class JqgridEventController {
	
	@Autowired
	private volatile IEventService service;

	@RequestMapping
	public String getEventPage(Model model) {
		model.addAttribute("events", service.readAll());
		return "jqgrid/event-page";
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
	public @ResponseBody JqgridTableDto<Event> getall() {

		List<Event> events = service.readAll();
		
		if (events != null) {
			JqgridTableDto<Event> response = new JqgridTableDto<Event>();
			response.setRows(events);
			response.setRecords(new Integer(events.size()).toString());
			response.setTotal(new String("1"));
			response.setPage(new String("1"));
			
			return response;
		}
		
		return new JqgridTableDto<Event>();
	}
}
