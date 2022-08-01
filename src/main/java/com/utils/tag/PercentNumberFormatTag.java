package com.utils.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.utils.Util;

public class PercentNumberFormatTag extends TagSupport {
	private static final long serialVersionUID = -7574133164130967785L;
	
	private static final Logger logger = LoggerFactory.getLogger(PercentNumberFormatTag.class);

	public PercentNumberFormatTag() {
		super();
	}
	
	private String value;
	
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
			
			if(Double.isInfinite(Double.parseDouble(value))) {
				result = "*";
			} else if (Double.parseDouble(value) >= 1000) {
				result = "*";
			} else if (Double.parseDouble(value) == 0 || Double.isNaN(Double.parseDouble(value))) {
				result = "0";
			} else if (value.contains(".")){
				String tmpStr = value.split("[.]")[1];
				if(tmpStr.length() < 3) {
					result = value;
				} else {
					result = Util.percentNumFormat(value);
				}
			} else {
				result = Util.percentNumFormat(value);
			}
			
			this.pageContext.getOut().print(result + " %");
		} catch (IOException e) {
			throw new JspException(e);
		}
		return SKIP_BODY;
	}
}
