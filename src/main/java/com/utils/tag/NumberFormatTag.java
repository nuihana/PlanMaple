package com.utils.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.utils.Util;

public class NumberFormatTag extends TagSupport {
	private static final long serialVersionUID = 4800290958334623769L;
	
	private static final Logger logger = LoggerFactory.getLogger(NumberFormatTag.class);

	public NumberFormatTag() {
		super();
	}
	
	private String value;
	private String format = ",";

	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) throws JspException {
		this.value = (String)ExpressionEvaluatorManager.evaluate("value", value, String.class, this, pageContext);
	}
	
	public int doStartTag() throws JspException {
		String result = "";
		
		try {
			logger.debug("##value = " + getValue());
			logger.debug("##format = " + getFormat());
			
			result = Util.numFormat(value, format);
			
			this.pageContext.getOut().print(result);
		} catch (IOException e) {
			throw new JspException(e);
		}
		return SKIP_BODY;
	}
}
