package com.utils;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Util {
	private static final int SOCIALNO_HIDDEN_VALUE = 11;					//비교값
	private static final String SOCIALNO_SUCCESS = "SCM0000";			//정상
	private static final String SOCIALNO_LENGTH_ERRCODE = "SCM0001";		//자릿수 오류
	private static final String SOCIALNO_NUMERIC_ERRCODE = "SCM0002";	//숫자로 구성되어있지 않음
	private static final String SOCIALNO_TYPE_ERRCODE = "SCM0003";		//주민번호 형식오류
	private static final String SOCIALNO_NULL_ERRCODE = "SCM9000";		//NULL 오류
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 소문자 a-z, 숫자0-9 범위내의 랜덤 문자를 리턴한다.
	 * @param length 출력하고자하는 랜덤 문자열의 길이
	 * @return
	 */
	public static String getRandomString(int length){
		char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
		return getRandomString(length, charaters);
	}
	
	/**
	 * 대상케릭터 배열과 문자열의 길이를 받아 범위내의 랜덤 문자를 리턴한다.
	 * @param length 출력하고자하는 랜덤 문자열의 길이
	 * @param charaters 랜덤으로 추출할 대상 케릭터배열
	 * @return
	 */
	public static String getRandomString(int length, char[] charaters){
		StringBuilder sb = new StringBuilder("");
        Random rn = new Random();
        for( int i = 0 ; i < length ; i++ ){
        	sb.append( charaters[ rn.nextInt( charaters.length ) ] );
        }
        return sb.toString();
	}
	
	/**
	 * 대상 문자열이 <code>null</code>이거나 빈문자열이면 대체문자열을 아니면 대상문자열 그대로를 리턴한다.
	 * @Date	: 2013. 2. 3.
	 * @param source 대상문자열
	 * @param re	 대체문자열
	 * @return
	 */
	public static String nvl(CharSequence source, String re) {
		CharSequence val = hasText(source) ? source : re;
		return val.toString();
	}

	/**
	 * 대상 문자열이 <code>null</code>이거나 빈문자열이면 대체문자열을 아니면 대상문자열 그대로를 리턴한다.
	 * @param source 대상문자열
	 * @return
	 */
	public static String nvl(CharSequence source) {
		return nvl(source, "");
	}

	/**
	 * 대상 Object가 <code>null<code>이면 빈문자열을 그렇지 않으면 toString()결과를 리턴한다.
	 * @Date	: 2013. 2. 3.
	 * @param o
	 * @return
	 */
	public static String nvl(Object o) {
		return o == null ? "" : o.toString();
	}

	/**
	 * 문자열의 왼쪽을 원하는 길이만큼의 케릭터를 채워넣는다.
	 * @param s
	 * @param addChar
	 * @param length
	 * @return
	 */
	public static String lpad(String s, char addChar, int length) {
		StringBuffer val = new StringBuffer();
		int currLength = s.length();
		for (int i = currLength; i < length; i++) {
			val.append(addChar);
		}
		return val.append(s).toString();
	}

	/**
	 * 문자열이 <code>null</code>이 아니고 길이가 1이상인 경우 true를 리턴한다.
	 * @Date	: 2013. 2. 3.
	 * @param str
	 * @return
	 */
	public static boolean hasLength(CharSequence str) {
		return str != null && str.length() > 0;
	}

	/**
	 * 문자열이 <code>null</code>이 아니고 길이가 1이상인 경우 true를 리턴한다.
	 * @Date	: 2013. 2. 3.
	 * @param str
	 * @return
	 */
	public static boolean hasLength(String str) {
		return hasLength(((CharSequence) (str)));
	}

	/**
	 * 문자열이 존재하는지 여부를 돌려준다. <code>null</code>이거나 빈문자열은 false를 리턴한다.
	 * @param str
	 * @return
	 */
	public static boolean hasText(CharSequence str) {
		if (!hasLength(str))
			return false;
		int strLen = str.length();
		for (int i = 0; i < strLen; i++)
			if (!Character.isWhitespace(str.charAt(i)))
				return true;

		return false;
	}

	/**
	 * 문자열이 존재하는지 여부를 돌려준다. <code>null</code>이거나 빈문자열은 false를 리턴한다.
	 * @param str
	 * @return
	 */
	public static boolean isNotBlank(CharSequence str) {
		return hasText(str);
	}

	/**
	 * 개행 문자("\r\n")를 <br />으로 변경한다.
	 * @param target
	 *            : 대상문자열
	 * @return : 개행문자를 BR태그로 변경한 문자열
	 */
	public static String carriagereturnToBr(String target) {
		String rtnVal = nvl(target).replaceAll(" ", "&nbsp;").replaceAll("\r\n", "<BR />").replaceAll("\n", "<BR />");
		return rtnVal;
	}

	/**
	 * 1. 개요 : 개행 문자("\r\n")를 <br />으로 변경한다. 
	 * 2. 처리내용 : 개행 문자("\r\n")를 <br />으로 변경한다.
	 * @Method Name : strToHtmlStyle
	 * @param str
	 * @return
	 */
	public static String strToHtmlStyle(String str) {
		String resultStr = "";

		if (str != null) {
			resultStr = str.replaceAll(" ", "&nbsp;");
			resultStr = resultStr.replaceAll("\r\n", "<BR />");
			resultStr = resultStr.replaceAll("\n", "<BR />");
		}

		return resultStr;
	}

	/**
	 * 1. 개요 : 문자열 포멧을 변경 한다.
	 * 2. 처리내용 : format 변경 ("12345", "00-00-0", '-') 으로 호출시 12-34-5로 반환한다 2009-10-16
	 * @Method Name : strFormat
	 * @param sourceStr
	 * @param format
	 * @param pattern
	 * @return
	 */
	public static String strFormat(String sourceStr, String format, char pattern) {
		String result = "";
		int sourceLength = sourceStr.length();

		if (sourceStr.equals("") || format.equals("")) {
			result = sourceStr;
		} else {
			int index = 0;
			int startIndex = 0;
			for (int i = 0; i < format.length(); i++) {
				if (format.charAt(i) == pattern) {
					result += sourceStr.substring(startIndex, index) + pattern;
					startIndex = index;
					index--;
				}
				index++;
				if (sourceLength <= index) {
					break;
				}
			}
			if (startIndex > 0) {
				result += sourceStr.substring(startIndex, index);
			} else {
				result = sourceStr;
			}
		}

		return result;
	}

	/**
	 * 1. 개요 : 주민등록번호 형식 체크
	 * 2. 처리내용 : 주민등록번호 형식 체크
	 * @Method Name : socialNoCheck
	 * @param socialNo
	 * @return
	 */
	public static String socialNoCheck(String socialNo) {
		String returnMessage = "";

		int[] socialNoPattern = { 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 };
		int[] socialNoArray = new int[13];
		int socialLastNo = 0;
		int socialCheckValue = 0;
		int socialModValue = 0;

		if (socialNo == null) {
			returnMessage = SOCIALNO_NULL_ERRCODE;
		} else if (socialNo.length() != 13) {
			returnMessage = SOCIALNO_LENGTH_ERRCODE;
		} else if (!isNumber(socialNo)) {
			returnMessage = SOCIALNO_NUMERIC_ERRCODE;
		}

		if (returnMessage.equals("")) {
			for (int i = 0; i < socialNo.length(); i++) {
				socialNoArray[i] = Character.getNumericValue(socialNo.charAt(i));
			}

			socialLastNo = socialNoArray[socialNoArray.length - 1];
			for (int i = 0; i < socialNoPattern.length; i++) {
				socialCheckValue += socialNoArray[i] * socialNoPattern[i];
			}

			socialModValue = socialCheckValue % SOCIALNO_HIDDEN_VALUE;

			if (socialModValue == 0) {
				socialModValue = 10;
			} else if (socialModValue == 1) {
				socialModValue = 11;
			}

			if ((SOCIALNO_HIDDEN_VALUE - socialModValue) == socialLastNo) {
				returnMessage = SOCIALNO_SUCCESS;
			} else {
				returnMessage = SOCIALNO_TYPE_ERRCODE;
			}
		}

		return returnMessage;
	}

	/**
	 * 입력된 값이 숫자로만 구성되었는지 확인한다.
	 * @Method Name : isOnlyNumCheck
	 * @param input
	 * @return
	 */
	public static boolean isNumber(String input) {
		String chars = "0123456789";
		if (input == null) {
			return false;
		}
		if ("".equals(input)) {
			return false;
		}

		for (int inx = 0; inx < input.length(); inx++) {
			if (chars.indexOf(input.charAt(inx)) == -1) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 1. 개요 : 원단위(금액)형식으로 변경 한다.
	 * 2. 처리내용 : 12345 => 12,345
	 * @Method Name : numFormat
	 * @param number
	 * @param format
	 * @return
	 */
	public static String numFormat(String number, String format) {
		String numberStr = number;
		String tmpNumberStr = "";
		int strLenght = numberStr.length();
		int sit = 0;

		if (strLenght > 3) {
			sit = strLenght % 3;

			if (sit > 0) {
				tmpNumberStr += numberStr.substring(0, sit) + format;
				strLenght -= sit;
			}

			while (strLenght > 3) {
				tmpNumberStr += numberStr.substring(sit, sit + 3) + format;
				strLenght -= 3;
				sit += 3;
			}

			tmpNumberStr += numberStr.substring(sit, sit + 3);
			numberStr = tmpNumberStr;
		}

		return numberStr;
	}

	/**
	 * 1. 개요 : 백분율(xx.xx)형식으로 변경 한다.
	 * 2. 처리내용 : 12.345678 => 12.34
	 * @Method Name : percentNumFormat
	 * @param number
	 * @param format
	 * @return
	 */
	public static String percentNumFormat(String number) {
		String[] tmpStr;
		if(number.contains(".")) {
			tmpStr = number.split("[.]");
		} else {
			return number;
		}
		String tmpSmNum = tmpStr[1];
		int strLenght = tmpSmNum.length();
		
		if(strLenght > 2) {
			tmpSmNum = tmpSmNum.substring(0, 2);
		}

		return tmpStr[0] + "." + tmpSmNum;
	}

	/**
	 * 지정된 Encoding으로 변환 한다.
	 * @Method Name : getEncoding
	 * @param strVal
	 * @param org
	 * @param enc
	 * @return
	 */
	public static String getEncoding(String strVal, String org, String enc) {

		String returnVal = "";

		try {
			returnVal = new String(strVal.getBytes(org), enc);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return returnVal;
	}

	/**
	 * ISO8859_1 을 KSC5601로 변경
	 * @param Unicodestr
	 *            : String ISO8859_1 캐릭터 셋.
	 * @return KSC5601로 변환된 캐릭터 셋.
	 */
	public static String ksc5601(String Unicodestr) {
		if (Unicodestr == null) {
			return null;
		}

		String str = null;

		try {
			str = new String(Unicodestr.getBytes("8859_1"), "KSC5601");
		} catch (java.io.UnsupportedEncodingException e) {
			str = Unicodestr;
		} catch (Exception e) {
			return str;
		}

		return str;
	}

	/**
	 * KSC5601 을  ISO8859_1 로 변경
	 * @param Unicodestr
	 *            String KSC5601 캐릭터 셋.
	 * @return String ISO8859_1로 변환된 캐릭터 셋.
	 */
	public static String iso8859(String Unicodestr) {
		if (Unicodestr == null) {
			return null;
		}

		String str = null;

		try {
			str = new String(Unicodestr.getBytes("KSC5601"), "8859_1");
		} catch (java.io.UnsupportedEncodingException e) {
			str = Unicodestr;
		} catch (Exception e) {
			return str;
		}

		return str;
	}

	/**
	 * 8859_1를 KSC5601 변경
	 * @param str
	 * @return
	 */
	public static String uni2Ksc(String str) {
		String retstr = null;
		if (str != null) {
			try {
				retstr = new String(str.getBytes("8859_1"), "KSC5601");
			} catch (UnsupportedEncodingException e) {
				return str;
			} catch (Exception e) {
				return str;
			}
			return retstr;
		} else
			return "";
	}

	/**
	 * 반올림한다.
	 * @param d
	 *            숫자
	 * @param p
	 *            자리수
	 * @return double
	 */
	public static double round(double d, int p) {
		long tmp = (long) Math.pow(10, p);
		double num = Math.round(d * tmp);
		num /= tmp;
		return num;
	}

	/**
	 * 절상한다.
	 * @param d
	 *            숫자
	 * @param p
	 *            자리수
	 * @return double
	 */
	public static double ceil(double d, int p) {
		long tmp = (long) Math.pow(10, p);
		double num = Math.ceil(d * tmp);
		num /= tmp;
		return num;
	}

	/**
	 * 절상한다.
	 * @param d
	 *            숫자
	 * @param p
	 *            자리수
	 * @return double
	 */
	public static double ceil2(double d, int p) {
		long tmp = (long) Math.pow(10, p);
		double num = Math.ceil(d / tmp);
		num *= tmp;
		return num;
	}

	/**
	 * 절사한다.
	 * @param d
	 *            숫자
	 * @param p
	 *            자리수
	 * @return double
	 */
	public static double floor(double d, int p) {
		long tmp = (long) Math.pow(10, p);
		double num = Math.floor(d * tmp);
		num /= tmp;
		return num;
	}

	/**
	 * 외화금액에 대하여 단수처리한다.(소수 3자리 반올림)
	 * @param amt
	 *            금액
	 * @return double
	 */
	public static double formatAmtF(double amt) {
		return round(amt, 2);
	}

	/**
	 * 원화금액에 대하여 단수처리한다.(원미만 절사)
	 * @param amt
	 *            금액
	 * @return double
	 */
	public static long formatAmtW(double amt) {
		return (long) floor(amt, 0);
	}

	/**
	 * 문자열중의 특정스트링을 변환하는 함수
	 * @param str
	 *            원래문자열
	 * @param token
	 *            바뀔문자열
	 * @param to
	 *            바꿀문자열
	 * @return String
	 */
	public static String replace(String str, String token, String to) {
		String resultStr = "";

		if (str == null || str.equals("")) {
			return resultStr;
		} else {

			int idx = -1;
			while ((idx = str.indexOf(token)) != -1) {
				resultStr += str.substring(0, idx) + to;
				str = str.substring(idx + token.length());
			}
			resultStr += str;

			return resultStr;
		}
	}

	/**
	 * 숫자금액을 문자금액으로 변환(둘다 스트링 타입)
	 * @param string
	 *            amt
	 * @return string price
	 */
	public static String convPrice(String amt) {
		String danwee = "";
		String price = "";
		String flag = "N";
		int amtLen = amt.length();

		for (int i = 1; i <= amtLen; i++) {

			switch (amt.charAt(amtLen - i)) {

			case '1':
				danwee = "일";
				break;
			case '2':
				danwee = "이";
				break;
			case '3':
				danwee = "삼";
				break;
			case '4':
				danwee = "사";
				break;
			case '5':
				danwee = "오";
				break;
			case '6':
				danwee = "육";
				break;
			case '7':
				danwee = "칠";
				break;
			case '8':
				danwee = "팔";
				break;
			case '9':
				danwee = "구";
				break;
			case '0':
				continue;
			}

			if (i == 1) {
				price = danwee;
				continue;
			}

			switch ((i - 1) % 4) {
			case 1:
				danwee = danwee + "십";
				break;
			case 2:
				danwee = danwee + "백";
				break;
			case 3:
				danwee = danwee + "천";
				break;
			case 0:
				break;
			}

			if (i > 4 && i < 9 && !flag.equals("M")) {
				danwee = danwee + "만";
				flag = "M";
			}
			if (i >= 9 && i < 13 && !flag.equals("U")) {
				danwee = danwee + "억";
				flag = "U";
			}
			if (i >= 13 && !flag.equals("J")) {
				danwee = danwee + "조";
				flag = "J";
			}

			price = danwee + price;
		}
		return price;
	}

	/**
	 * Base64로 encoding한다.
	 * @param baseStr
	 *            인코딩할 문자
	 * @return
	 */
	public static String encodingBase64(String baseStr) {

		String encodedStr = "";
		try {
			encodedStr = new String(org.apache.commons.codec.binary.Base64.decodeBase64(baseStr));
		} catch (Exception e) {
			encodedStr = "";
		}
		return encodedStr;
	}

	/**
	 * Base64 decoding한다.
	 * @param baseStr
	 *            Base64로 encoding된 문자열
	 * @return
	 */
	public static String decodingBase64(String baseStr) {
		
		String decodedStr = "";
		try {
			decodedStr = new String(org.apache.commons.codec.binary.Base64.decodeBase64(baseStr));
		} catch (Exception e) {
			decodedStr = "";
		}
		return decodedStr;
	}

	/**
	 * @param value
	 * @param decimalCnt
	 * @return
	 */
	public static String decimalFormat(double value, int decimalCnt) {
		String resultValue = "";
		String pattern = "";

		if (decimalCnt > 0) {
			for (int i = 0; i < decimalCnt; i++) {
				pattern += "#";
			}

			pattern = "." + pattern;
			DecimalFormat df = new DecimalFormat(pattern);
			resultValue = df.format(value);
		} else {
			resultValue = String.valueOf(value);
		}
		return resultValue;
	}
	
	/**
	 * 문자열 일부 *처리
	 * @param baseStr
	 * @return
	 */
	public static String setMosaic(String baseStr) {
		String resultValue = "";
		StringBuilder sb = new StringBuilder();
		
		int length = baseStr.length();
		int limit = (length > 1) ? (length > 4) ? (length > 7) ? 3 : 2 : 1 : 0;
		
		for (int i = 0; i < length; i++) {
			char tmp = baseStr.charAt(i);
			
			if (length - i > 1 && length - i <= limit + 1) {
				sb.append("*");
			} else {
				sb.append(tmp);
			}
		}
		
		resultValue = sb.toString();
		
		return resultValue;
	}
}
