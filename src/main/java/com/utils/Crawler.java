package com.utils;

import java.io.IOException;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class Crawler {
	/**
	 * url 요청시 반환되는 html 출력, 페이지 로드 후 브라우저에서 이루어지는 동적 변화는 수집 불가
	 * @param url 요청 url
	 * @return
	 */
	public String getResponseHTML(String url) {
		String result = "";
		
		try {
			Connection conn = Jsoup.connect(url);
			
			Document html = conn.get();
			
			result = html.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * url 요청시 반환되는 html에서 특정 selector에 해당하는 값을 추출
	 * @param url 요청 url
	 * @param selector id, name 등 attribute명
	 * @param target 해당 select값
	 * @return
	 */
	public String getValueFromResponseHTMLByAttribute(String url, String selector, String target) {
		String result = "";
		
		try {
			Connection conn = Jsoup.connect(url);
			
			Document html = conn.get();
			
			String destination = "";
			if (selector.equals("class")) {
				destination += ".";
			} else if (selector.equals("id")) {
				destination += "#";
			} else {
				return "지원하지 않는 데이터형입니다.";
			}
			destination += target;
			
			//요소 탐색
			Elements elements = html.select(destination);
			for (Element elm : elements) {
				String text = elm.html();
				
				result += text + "|";
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String getCharacterInfoFromHTML(String url) {
		String result = "";
		
		try {
			Connection conn = Jsoup.connect(url);
			
			Document html = conn.get();
			
			//요소 탐색
			Elements elements = html.select(".search_com_chk td");
			int idx = 0;
			for (Element elm : elements) {
				if (idx == 1) {
					result += elm.select("a").text() + "|";
					result += elm.select("dd").text().split("[/]")[1].trim() + "|";
					result += elm.select("img").get(0).attr("src") + "|";
					result += elm.select("img").get(2).attr("src").split("world_icon")[1].replaceAll("[^0-9]", "") + "|";
				} else if (idx == 2) {
					result += elm.text().replaceAll("[^0-9]", "");
				}
				
				idx++;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 요청된 String을 jsoup.nodes.Document 객체로 반환
	 * @param str 요청 url
	 * @return
	 */
	public Document convertStringToDocument(String str) {
		
        return Jsoup.parse(str);
	}
}