package com.ysis.webapp.common.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils {
	public static String substringDependCharacter(String str, int size) {
		int subLength = 0;
		StringBuffer result = new StringBuffer();
		for (int i = 0; i < str.length(); i++) {
			if (subLength >= size) {
				result.append("..");
				break;
			}
			if (Character.getType(str.charAt(i)) == 5)
				subLength += 2;
			else
				subLength += 1;
			result.append(str.charAt(i));
		}
		return result.toString();
	}

	public static String getFchar(int size, String str) {
		str = (int) Double.parseDouble(str) + "";
		String chr = "0000000000";
		if (str.length() < size)
			str = chr.substring(0, size - str.length()) + str;
		return str;
	}

	public static String escapeXml(String str) {
		if (str == null || "".equals(str.trim()))
			return null;

		if (str.indexOf("&") != -1)
			str = str.replaceAll("&", "&amp;");
		if (str.indexOf(">") != -1)
			str = str.replaceAll(">", "&gt;");
		if (str.indexOf("<") != -1)
			str = str.replaceAll("<", "&lt;");
		if (str.indexOf("'") != -1)
			str = str.replaceAll("'", "&#39;");
		if (str.indexOf("\"") != -1)
			str = str.replaceAll("\"", "&quote;");
		return str;
	}

	public static int roundDecimal(int point, int pointCount) {
		if (point < 1 || pointCount < 1)
			return 0;

		double d = new Double(point).doubleValue() / new Double(pointCount).doubleValue();
		d = Math.round(d * 10.00) / 10.00;

		String prefix = (d + "").split("\\.")[0];
		String surfix = (d + "").split("\\.")[1];

		String result = null;
		if (Integer.parseInt(surfix) < 3) {
			result = prefix + "0";
		} else if (Integer.parseInt(surfix) > 7) {
			result = (Integer.parseInt(prefix) + 1) + "0";
		} else {
			result = prefix + "5";
		}

		return new Integer(result).intValue();
	}

	public static List<Object> getKeywordList(String keywords) {
		if (keywords != null) {
			List<Object> keywordList = new ArrayList<>();
			StringTokenizer splitter = new StringTokenizer(keywords, " ", false);
			while (splitter.hasMoreTokens()) {
				keywordList.add("%" + splitter.nextToken() + "%");
			}
			return keywordList;
		}
		return null;
	}

	public static List<Object> getSearchList(String keywords) {
		if (keywords != null) {
			List<Object> keywordList = new ArrayList<>();
			String[] splitter = keywords.split(",");

			for (int i = 0; i < splitter.length; i++) {
				keywordList.add(splitter[i].replace(" ", ""));
			}

			return keywordList;
		}
		return null;
	}

	public static int toInteger(String val) {
		return toInteger(val, 0);
	}

	public static int toInteger(String val, int defaultInt) {
		try {
			return Integer.parseInt(val, defaultInt);
		} catch (Exception e) {
			return defaultInt;
		}
	}

	public static boolean isEqual(String str1, String str2) {
		return str1.equals(str2);
	}

	public static String getString(Object obj) {
		try {
			return obj.toString();
		} catch (Exception e) {
			return "";
		}
	}

	public static String getString(Object obj, String defaultStr) {
		try {
			return obj.toString();
		} catch (Exception e) {
			return defaultStr;
		}
	}
	
	public static String toRegexRemove(String defaultStr) {
		// 해당문자 다 지우기
		// 해당문자 => !\"#$%&{}@`*:+;<>,^~|' 
		Pattern pattern = Pattern.compile("[!\\\"#$%&{}@`*:+;<>^~|']");
		Matcher matcher = pattern.matcher(defaultStr);
		String result = matcher.replaceAll("");
		
		// 공백은 언더바로 치환
		pattern = Pattern.compile("[ ]");
		matcher = pattern.matcher(result);
		result = matcher.replaceAll("_");
		
		return result; 
	}
	
	public static String encoding(String text, String encode) {
		if (text == null || text.trim().length() == 0) {
			return null;
		}

		try {
			return URLEncoder.encode(text, encode).replace("%2F", "\\");
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	public static String decoding(String text, String decode) {
		if (text == null || text.trim().length() == 0) {
			return null;
		}

		try {
			return URLDecoder.decode(text, decode);
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
}