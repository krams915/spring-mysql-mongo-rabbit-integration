package org.krams.tutorial.controller;

import java.util.List;

import org.krams.tutorial.domain.ErrorLog;
import org.krams.tutorial.dto.ResponseDto;
import org.krams.tutorial.repository.mongo.IErrorLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/error")
public class ErrorController {
	

	@Autowired
	private IErrorLogRepository errorLogRepository;
	
	@RequestMapping
	public String getErrorPage() {
		return "error-page";
	}
	
	@RequestMapping(value = "/getall", method = RequestMethod.POST)
	public @ResponseBody ResponseDto<ErrorLog> getall() {

		List<ErrorLog> errors = errorLogRepository.findAll();
		
		if (errors != null) {
			return new ResponseDto<ErrorLog>(true, errors);
		}

		return new ResponseDto<ErrorLog>(false);
	}
}
