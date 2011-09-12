package org.krams.tutorial.util;

import org.apache.log4j.Logger;

public class ErrorUtil {
	protected static Logger logger = Logger.getLogger("service");
	
	public static final String EMPTY_TYPE = "Empty Type";
	public static final String NPE_EMPTY_TYPE = "NullPointerException Type";
	public static final String NULL_EMPTY_TYPE = "Null Type";
	
	public static String getErrorType(Exception ex) {
		String errorType = EMPTY_TYPE;
		
		try {
			errorType = ex.getCause().toString();
		} catch (NullPointerException npe) {
			errorType = NPE_EMPTY_TYPE;
		}
		
		if (errorType == null || errorType.isEmpty() == true) {
			errorType = NULL_EMPTY_TYPE;
		}
		
		logger.debug("Error type: " + errorType);
	
		return errorType;
	}
}
