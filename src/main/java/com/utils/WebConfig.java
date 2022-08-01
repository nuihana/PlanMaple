package com.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class WebConfig {
	private Logger logger = LoggerFactory.getLogger(this.getClass());	
	static Properties properties;

	public WebConfig() {
		if (properties == null) {
			properties = new Properties();
		}
	}
	
	public String getValue(String key) {
		return properties.getProperty(key);
	}
	
	public void setValue(String key, String value) {
		properties.setProperty(key, value);
	}
	
	public void initalize(String fileLocation) {
		logger.info("initalize - config file.");
		properties = new Properties();
		InputStream stream = null;
		InputStreamReader streamReader = null;
		
		try {
			stream = new FileInputStream(fileLocation);
			streamReader = new InputStreamReader(stream, "UTF-8");
			properties.load(streamReader);
		} catch (FileNotFoundException e) {
			logger.info("FileNotFoundException->" + e.getMessage());
		} catch (IOException e) {
			logger.info("IOException->" + e.getMessage());
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e) { }
			}
			if (streamReader != null) {
				streamReader = null;
			}
		}
		
		properties.setProperty("os.name", System.getProperty("os.name"));
		properties.setProperty("java.version", System.getProperty("java.version"));
		
		// vsc.conf 에 없을수 있는 값들 처리
		if(properties.getProperty("client.title") == null || properties.getProperty("client.title").equals("")) properties.setProperty("client.title", properties.getProperty("client"));
		
		//system log
		if(properties.getProperty("log.show") == null || properties.getProperty("log.show").equals("")) properties.setProperty("log.show", "");
		if(properties.getProperty("log.param") == null || properties.getProperty("log.param").equals("")) properties.setProperty("log.param", "");
	}
}
