
package com.utils.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StrToHtmlStyleTag extends TagSupport {
	private static final long serialVersionUID = -3880017913158230142L;

	private static final Logger logger = LoggerFactory.getLogger(StrToHtmlStyleTag.class);

	public StrToHtmlStyleTag() {
		super();
	}

	private String source = "";

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		try {
			this.source = (String) ExpressionEvaluatorManager.evaluate("source", source, String.class, this, pageContext);
		} catch (JspException e) {
			e.printStackTrace();
		}
	}

	public int doStartTag() throws JspException {
		String result = "";
		try {
			logger.debug("##source = " + getSource());

			if (!getSource().equals("")) {
				result = getSource().replaceAll(" ", "&nbsp;");
				result = result.replaceAll("\r\n", "<BR />");
				result = result.replaceAll("\n", "<BR />");
			}

			this.pageContext.getOut().print(result);
		} catch (IOException e) {
			throw new JspException(e);
		}
		return SKIP_BODY;
	}

}
