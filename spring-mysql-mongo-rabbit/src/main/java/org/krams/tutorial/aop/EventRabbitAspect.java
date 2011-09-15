package org.krams.tutorial.aop;

import java.util.Date;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * Interceptor for publishing messages to RabbitMQ 
 * 
 * @author krams at {@link http://krams915@blogspot.com}
 */
@Aspect
@Order(1)
@Component
public class EventRabbitAspect {

	protected Logger logger = Logger.getLogger("aop");

	@Autowired
	private volatile AmqpTemplate amqpTemplate;
	
	public static final String RABBIT_EXCHANGE = "eventExchange";
	public static final String GENERAL_EVENT_ROUTE_KEY = "event.general.*";
	public static final String ERROR_EVENT_ROUTE_KEY = "event.error.*";
	
	@Around("execution(* org.krams.tutorial.service.EventService.*(..))")
	public Object interceptService(ProceedingJoinPoint pjp) throws Throwable {
		
		try {
			
			logger.debug("Publishing event to RabbitMQ");
			this.amqpTemplate.convertAndSend(RABBIT_EXCHANGE, GENERAL_EVENT_ROUTE_KEY, new Date() + ": " + pjp.toShortString());

			return pjp.proceed();
			
		} catch (Exception e) {
			
			logger.debug("Publishing event to RabbitMQ");
			this.amqpTemplate.convertAndSend(RABBIT_EXCHANGE, ERROR_EVENT_ROUTE_KEY, new Date() + ": " + pjp.getSignature().toLongString() + " - " + e.toString());
			
			return pjp.proceed();
		}
	}
}
