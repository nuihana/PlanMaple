package com.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class webClient {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	private int TIME_OUT = 8000;
	
	public String callHttpPOST(String urlString, String reqString) {
		String output = "";
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse response = null;
		
		try {
			StringEntity strAccessData = new StringEntity(reqString, "UTF-8");
			RequestConfig reqConfig = RequestConfig.custom()
					.setSocketTimeout(TIME_OUT)
					.setConnectTimeout(TIME_OUT)
					.setConnectionRequestTimeout(TIME_OUT)
					.build();
			
			httpClient = HttpClientBuilder.create()
					.setDefaultRequestConfig(reqConfig)
					.build();
			
			HttpPost postRequest = new HttpPost(urlString);
			postRequest.setConfig(reqConfig);
			
			//strAccessData.setContentType("application/json; charset=UTF-8");
			postRequest.setEntity(strAccessData);
			postRequest.setHeader("Content-Type", "application/json; charset=UTF-8");
			postRequest.setHeader("VSC-ID", config.getValue("vscID"));
			postRequest.setHeader("Cache-Control", "no-cache");
			
			response = httpClient.execute(postRequest);
			int statusCode = response.getStatusLine().getStatusCode();
			
			if (statusCode != 200) {
				output = "ERR_" + response.getStatusLine().getStatusCode();
				//throw new RuntimeException("Failed : HTTP error code : " + response.getStatusLine().getStatusCode());
			} else {
				BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent()), "UTF-8"));
				StringBuilder sb = new StringBuilder("");
				
				while ((output = br.readLine()) != null) {
					sb.append(output);
				}
				output = sb.toString();
			}
		} catch (Exception e) {
			logger.info("callHttpPOST Error ->" + e.getMessage());
			
			//if (e.getMessage().indexOf("Connection refused") > 0) {
				// xrL4 서비스 이상으로 판단
				config.setValue("vsc.url", config.getValue("vsc.url_backup"));
				logger.info("VSC Server -> " + config.getValue("vsc.url"));
			//}
			
			output = "ERR_FAIL";
		} finally {
			if (response != null) {
				response = null;
			}
			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) { }
			}
		}
		
		//logger.info("output->" + output);
		return output;
	}
	
	public String callHttpPOST(String vscID, String urlString, String reqString) {
		String output = "";
		CloseableHttpClient httpClient = null;
		CloseableHttpResponse response = null;
		
		try {
			StringEntity strAccessData = new StringEntity(reqString, "UTF-8");
			RequestConfig reqConfig = RequestConfig.custom()
					.setSocketTimeout(TIME_OUT)
					.setConnectTimeout(TIME_OUT)
					.setConnectionRequestTimeout(TIME_OUT)
					.build();
			
			httpClient = HttpClientBuilder.create()
					.setDefaultRequestConfig(reqConfig)
					.build();
			
			HttpPost postRequest = new HttpPost(urlString);
			postRequest.setConfig(reqConfig);
			
			//strAccessData.setContentType("application/json; charset=UTF-8");
			postRequest.setEntity(strAccessData);
			postRequest.setHeader("Content-Type", "application/json; charset=UTF-8");
			postRequest.setHeader("VSC-ID", config.getValue("vscID"));
			postRequest.setHeader("Cache-Control", "no-cache");
			
			response = httpClient.execute(postRequest);
			int statusCode = response.getStatusLine().getStatusCode();
			
			if (statusCode != 200) {
				output = "ERR_" + response.getStatusLine().getStatusCode();
				//throw new RuntimeException("Failed : HTTP error code : " + response.getStatusLine().getStatusCode());
			} else {
				BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent()), "UTF-8"));
				StringBuilder sb = new StringBuilder("");
				
				while ((output = br.readLine()) != null) {
					sb.append(output);
				}
				output = sb.toString();
			}
		} catch (Exception e) {
			logger.info("callHttpPOST Error ->" + e.getMessage());
			output = "ERR_FAIL";
		} finally {
			if (response != null) {
				response = null;
			}
			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) { }
			}
		}
		
		//logger.info("output->" + output);
		return output;
	}
	
	public String uploadFile2Web(String vscID, String urlString, String fileLocation) {
		String output = "";
		CloseableHttpClient httpClient = null;
		HttpResponse response = null;

		try {
			File imgFile = new File(fileLocation);
			HttpPost post = new HttpPost(urlString);
			post.addHeader("Content-Type", "multipart/mixed; boundary=\"---Content Boundary\"");
			post.addHeader("VSC-ID", vscID);
			
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			builder.addBinaryBody("uploadFile", imgFile, ContentType.DEFAULT_BINARY, imgFile.getName());
			builder.setBoundary("---Content Boundary");
			
			httpClient = HttpClientBuilder.create().build();
			HttpEntity entity = builder.build();
			post.setEntity(entity);
			response = httpClient.execute(post);
			if (response != null) {
				HttpEntity responseEntity = response.getEntity();
				if (responseEntity != null) {
					InputStream responseStream = responseEntity.getContent() ;
                    if (responseStream != null){
                    	BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent()), "UTF-8"));
            			StringBuilder sb = new StringBuilder("");
            			
            			while ((output = br.readLine()) != null) {
            				sb.append(output);
            			}
            			output = sb.toString();
                    }
                    responseStream.close();
				}
			}
		} catch (Exception e) {
			logger.info("callHttpPOST Error ->" + e.getMessage());
			output = "ERR_FAIL";
		} finally {
			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) { }
			}
			if (response != null) {
				response = null;
			}
		}
		
		//logger.info("output->" + output);
		return output;
	}
	
	public void downloadUsingNIO(String sourceUrl, String targetFile) throws IOException {
        URL url = new URL(sourceUrl);
        ReadableByteChannel rbc = Channels.newChannel(url.openStream());
        FileOutputStream fos = new FileOutputStream(targetFile);
        fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        fos.close();
        rbc.close();
    }
}
