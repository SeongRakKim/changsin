package com.changsin.webapp.common.util;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.*;

public final class CommonUtils {
	private CommonUtils() {}

	public static String nvl(String src) {
		return nvl(src, "");
	}

	public static String nvl(String src, String obj) {
		if (src == null)
			src = obj;
		return src.trim();
	}

	public static boolean isEmpty(Object s) {
		if (s == null) {
			return true;
		}
		if ((s instanceof String) && (((String) s).trim().length() == 0)) {
			return true;
		}
		if (s instanceof Map) {
			return ((Map<?, ?>) s).isEmpty();
		}
		if (s instanceof List) {
			return ((List<?>) s).isEmpty();
		}
		if (s instanceof Object[]) {
			return (((Object[]) s).length == 0);
		}

		return false;
	}

	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}
	
	public static boolean isNumber(String val) {
		boolean result = true;
		try {
			Integer.parseInt(val);
		} catch (Exception e) {
			result = false;
		}
		return result;
	}

	public static String stripTag(String html) {
		return html.replaceAll("<[^>]*>", "");
	}

	public static boolean isArray(Object obj) {
		return obj instanceof Object[];
	}

	public static String join(Object[] array, String separator) {
		return array == null ? null : join(array, separator, 0, array.length);
	}

	public static String join(Object[] array, String separator, int startIndex, int endIndex) {
		if (array == null) {
			return null;
		} else {
			if (separator == null) {
				separator = "";
			}

			int noOfItems = endIndex - startIndex;
			if (noOfItems <= 0) {
				return "";
			} else {
				StringBuilder buf = new StringBuilder(noOfItems * 16);

				for (int i = startIndex; i < endIndex; ++i) {
					if (i > startIndex) {
						buf.append(separator);
					}

					if (array[i] != null) {
						buf.append(array[i]);
					}
				}

				return buf.toString();
			}
		}
	}
	
	public static void saveDest(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String query = request.getQueryString();

		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}

//		if (request.getMethod().equals("GET")) {
//			request.getSession().setAttribute(BLDefine.GET_DEST, uri + query);
//		}
	}
	
	public static String encryptRsa(PublicKey publicKey, String value) throws Exception {
		Cipher cipher = Cipher.getInstance("RSA");
		byte[] valueBytes = hexToByteArray(value);
		cipher.init(Cipher.ENCRYPT_MODE, publicKey);
		byte[] encryptedBytes = cipher.doFinal(valueBytes);
		String encryptedValue = new String(encryptedBytes, "utf-8"); // 문자 인코딩 주의.
		return encryptedValue;
	}
	
	public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
		Cipher cipher = Cipher.getInstance("RSA");
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
		return decryptedValue;
	}

	public static byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() % 2 != 0) {
			return new byte[] {};
		}

		byte[] bytes = new byte[hex.length() / 2];
		for (int i = 0; i < hex.length(); i += 2) {
			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		return bytes;
	}
	
	public static Map<String, Object> convertObjectToMap(Object obj) {
		Map<String, Object> map = new HashMap<>();
		Field[] fields = obj.getClass().getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			fields[i].setAccessible(true);
			try {
				map.put(fields[i].getName(), fields[i].get(obj));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	public static Object convertMapToObject(Map<String, Object> map, Object obj) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator<String> itr = map.keySet().iterator();

		while (itr.hasNext()) {
			keyAttribute = (String) itr.next();
			methodString = setMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
			Method[] methods = obj.getClass().getDeclaredMethods();
			for (int i = 0; i < methods.length; i++) {
				if (methodString.equals(methods[i].getName())) {
					try {
						methods[i].invoke(obj, map.get(keyAttribute));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return obj;
	}
	
	public static boolean isCharEqual(String str, String equal, int index) {
		return String.valueOf(str.charAt(index)).equals(equal);
	}
}