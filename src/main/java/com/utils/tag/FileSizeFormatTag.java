package com.utils.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;

import com.utils.Util;

public class FileSizeFormatTag extends TagSupport {
	private static final long serialVersionUID = 8166392773055995217L;

	public FileSizeFormatTag() {
		value = "0";
		format = "2";
	}
	
	private String value = "";
	private String format = "";

	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		try {
			this.value = (String)ExpressionEvaluatorManager.evaluate("value", value, String.class, this, pageContext);
		} catch (JspException e) {
			e.printStackTrace();
		}
	}
	
	public int doStartTag() throws JspException {
		double fileSize = Double.parseDouble(getValue());
		double outputSize = 0.0d;
		
		int fileSizeType = Integer.parseInt(getFormat());
		
		String formatName = "Btye";
		String resultVlaue = "";
		
		try {
			switch (fileSizeType) {
			case 1:
				formatName = "Byte";
				break;
			case 2:
				formatName = "KB";
				break;
			case 3:
				formatName = "MB";
				break;
			case 4:
				formatName = "GB";
				break;
			case 5:
				formatName = "TB";
				break;
			default:
				break;
			}
			
			if(fileSizeType > 1) {
				outputSize = fileSize/(double)(Math.pow(1024, fileSizeType-1));
				resultVlaue = Util.decimalFormat(outputSize, 2);
			} else {
				resultVlaue = String.valueOf(fileSize);
			}
			
			this.pageContext.getOut().print(resultVlaue + "&nbsp;" + formatName);
		} catch (IOException e) {
			throw new JspException(e);
		}
		return SKIP_BODY;
	}
	
}
