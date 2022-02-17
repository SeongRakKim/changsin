package com.changsin.webapp.common.vo;

import lombok.*;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.lang.reflect.Array;
import java.net.URLEncoder;
import java.util.*;

public class VMap implements Cloneable, Serializable {
    private static final long serialVersionUID = 7983661182990100784L;

    public static final String REQUEST = "_REQUEST";
    public static final String SESSION = "_SESSION";
    public static final String APPLICATION = "_APPLICATION";
    public static final String COOKIE = "_COOKIE";
    public static final String REQUESTURI = "_REQUESTURI";
    public static final String DATA = "_DATA";

    private Map<String, Object> map = new LinkedHashMap<>();

    public VMap() {
        super();
    }

    public VMap(HttpServletRequest request) {
        this();
        init(request);
    }

    public static VMap set(HttpServletRequest request) {
        return new VMap(request);
    }

    public Object get(String key) {
        return map.get(key);
    }

    public void put(String key, Object value) {
        if(value != null) {
            map.put(key, value.equals("") ? null : value);
        }
        else {
            map.put(key, value);
        }
    }

    public Object remove(String key) {
        return map.remove(key);
    }

    public boolean containsKey(String key) {
        return map.containsKey(key);
    }

    public boolean containsValue(Object value) {
        return map.containsValue(value);
    }

    public void clear() {
        map.clear();
    }

    public Set<Map.Entry<String, Object>> entrySet() {
        return map.entrySet();
    }

    public Set<String> keySet() {
        return map.keySet();
    }

    public boolean isEmpty() {
        return map.isEmpty();
    }

    public void putAll(Map<? extends String, ? extends Object> m) {
        map.putAll(m);

        Set<String> keySet = map.keySet();
        Iterator<String> it = keySet.iterator();
        while (it.hasNext()) {
            String key = it.next();
            if(map.get(key).equals("")) {
                map.put(key, null);
            }
        }
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void init(HttpServletRequest request) {
        try {
            setArgument(request);
            setRequestURI(request);
            setSession(request);
            setCookie(request);

            HttpSession session = request.getSession();
            Map<?, ?> SESSION_URI_MAP = (Map<?, ?>) getSession("SESSION_URI_MAP");
            if (SESSION_URI_MAP == null) {
                SESSION_URI_MAP = new LinkedHashMap<Object, Object>();

                session.setAttribute("SESSION_URI_MAP", SESSION_URI_MAP);
                map.put("SESSION_URI_MAP" + VMap.SESSION, SESSION_URI_MAP);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("unchecked")
    public VMap useSessionURI() {
        Map<String, VMap> SESSION_URI_MAP = (Map<String, VMap>) getSession("SESSION_URI_MAP");
        if (SESSION_URI_MAP != null) {
            String URI = this.getRequestURI();
            Map<String, VMap> sessionData = null;
            try {
                sessionData = (Map<String, VMap>) SESSION_URI_MAP.get(URI);
            } catch (Exception e) {
            }

            if (sessionData != null && this.getParamCount() == 0) {
                this.putAll(sessionData);
            }
            SESSION_URI_MAP.put(URI, (VMap) this.clone());
        }
        return this;
    }

    public void setArgument(HttpServletRequest request) {
        try {
            Enumeration<?> keys = request.getParameterNames();
            String key = "";
            while (keys.hasMoreElements()) {
                key = (String) keys.nextElement();
                String[] values = request.getParameterValues(key);

                if (values != null && values.length == 1) {
                    this.put(key, values[0]);
                } else {
                    this.put(key, values);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setRequest(HttpServletRequest request) {
        try {
            Enumeration<?> enums = request.getAttributeNames();

            String key = "";
            while (enums.hasMoreElements()) {
                key = (String) enums.nextElement();
                this.put(key + VMap.REQUEST, request.getAttribute(key));
            }
        } catch (Exception e) {
        }
    }

    public void setSession(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            Enumeration<?> sessions = session.getAttributeNames();

            String key = "";
            while (sessions.hasMoreElements()) {
                key = (String) sessions.nextElement();
                this.put(key + VMap.SESSION, session.getAttribute(key));

//                if(key.equals(BLDefine.LOGIN)) {
//                    LoginVO loginVO = (LoginVO) session.getAttribute(key);
//                    this.put(BLDefine.CUST_CODE, this.getString(BLDefine.CUST_CODE, loginVO.getCust_cd()));
//                    this.put(BLDefine.FACT_CODE, this.getString(BLDefine.FACT_CODE, loginVO.getFact_cd()));
//                    this.put(BLDefine.USER_CODE, this.getString(BLDefine.USER_CODE, loginVO.getUser_cd()));
//                }
            }
        } catch (Exception e) {
        }
    }

    public void setApplication(HttpServletRequest request) {
        try {
            ServletContext sc = request.getSession().getServletContext();
            Enumeration<?> enums = sc.getAttributeNames();

            String key = "";
            while (enums.hasMoreElements()) {
                key = (String) enums.nextElement();
                this.put(key + VMap.APPLICATION, sc.getAttribute(key));
            }
        } catch (Exception e) {
        }
    }

    public void setCookie(HttpServletRequest request) {
        try {
            Cookie[] cookies = request.getCookies();
            Cookie cookie = null;
            for (int i = 0; i < cookies.length; i++) {
                cookie = cookies[i];
                this.put(cookie.getName() + VMap.COOKIE, URLEncoder.encode(cookie.getValue(), "utf-8"));
            }
        } catch (Exception e) {
        }
    }

    public void setRequestURI(HttpServletRequest request) {
        try {
            this.put(VMap.REQUESTURI, request.getRequestURI());
        } catch (Exception e) {
        }
    }

    public void set(Map<String, Object> map) {
        try {
            this.putAll(map);
        } catch (Exception e) {
        }
    }

    public void setMapLowerKey(Map<String, Object> map) {
        try {
            Set<String> set = map.keySet();
            Object[] hmKeys = set.toArray();
            String key = "";
            for (int i = 0; i < hmKeys.length; i++) {
                key = (String) hmKeys[i];
                Object value = map.get(key);
                if (key != null)
                    key = key.toLowerCase();
                this.put(key, value);
            }
        } catch (Exception e) {
        }
    }

    public Object getRequest(String key) {
        return this.get(key + VMap.REQUEST);
    }

    public String getRequestString(String key) {
        return (String) this.get(key + VMap.REQUEST);
    }

    public Object getSession(String key) {
        return this.get(key + VMap.SESSION);
    }

    public String getSessionString(String key) {
        return (String) this.get(key + VMap.SESSION);
    }

    public Object getApplication(String key) {
        return this.get(key + VMap.APPLICATION);
    }

    public String getApplicationString(String key) {
        return (String) this.get(key + VMap.APPLICATION);
    }

    public String getCookie(String key) {
        return (String) this.get(key + VMap.COOKIE);
    }

    public String getRequestURI() {
        return (String) this.get(VMap.REQUESTURI);
    }

    public String getString(String key) {
        String value = null;
        try {
            Object o = (Object) this.get(key);
            // Class c = o.getClass();
            if (o == null) {
                value = "";
            } else if (o.getClass().isArray()) {
                int length = Array.getLength(o);
                if (length == 0) {
                    value = "";
                } else {
                    Object item = Array.get(o, 0);
                    if (item == null) {
                        value = "";
                    } else {
                        value = item.toString();
                    }
                }
            } else
                value = o.toString();
        } catch (Exception e) {
            value = "";
        }
        return value;
    }

    public String getString(String key, String defaultValue) {
        String rtnStr = defaultValue;
        try {
            rtnStr = this.getString(key);
            if ("".equals(rtnStr.trim()))
                rtnStr = defaultValue;
        } catch (Exception e) {
        }
        return rtnStr;
    }

    public String getStr(String key) {
        return getString(key);
    }

    public String getStr(String key, String defaultValue) {
        return getString(key, defaultValue);
    }

    public String initString(String key, String defaultValue) {
        String rtnStr = defaultValue;
        try {
            rtnStr = this.getString(key);
            if ("".equals(rtnStr.trim())) {
                this.put(key, defaultValue);
                rtnStr = defaultValue;
            }
        } catch (Exception e) {
        }
        return rtnStr;
    }

    public String getParameter(String key) {
        String value = null;
        try {
            Object o = (Object) this.get(key);
            if (o == null) {
            } else if (o.getClass().isArray()) {
                int length = Array.getLength(o);
                if (length == 0) {
                } else {
                    Object item = Array.get(o, 0);
                    if (item == null) {
                    } else {
                        value = item.toString();
                    }
                }
            } else
                value = o.toString();
        } catch (Exception e) {
        }
        return value;
    }

    public String[] getParameterValues(String key) {
        return this.getStrArray(key);
    }

    public String[] getStrArray(String key) {
        String[] rtnStr = null;
        Object o = (Object) this.get(key);
        Class<? extends Object> c = o.getClass();
        if (o != null) {
            if (c.isArray()) {
                rtnStr = ((String[]) o);
            } else {
                rtnStr = new String[1];
                rtnStr[0] = o.toString();
            }
        }
        return rtnStr;
    }

    public ArrayList<String> getStrList(String key) {
        ArrayList<String> arr = new ArrayList<String>();
        try {
            Object o = (Object) this.get(key);
            Class<? extends Object> c = o.getClass();
            if (o != null) {
                if (c.isArray()) {
                    int length = Array.getLength(o);
                    if (length != 0) {
                        for (int i = 0; i < length; i++) {
                            Object tiem = Array.get(o, i);
                            if (tiem == null)
                                arr.add("");
                            else
                                arr.add(tiem.toString());
                        }
                    }
                } else
                    arr.add(o.toString());
            }
        } catch (Exception e) {
        }
        return arr;
    }

    public int getInt(String key) {
        String temp = this.getString(key, "0");
        int rtnInt = 0;
        try {
            rtnInt = Integer.parseInt(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnInt;
    }

    public int getInt(String key, int defaultValue) {
        String temp = this.getString(key);
        int rtnInt = 0;
        try {
            if (temp.equals(""))
                rtnInt = defaultValue;
            else
                rtnInt = Integer.parseInt(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnInt;
    }

    public long getLong(String key) {
        String temp = this.getString(key, "0");
        long rtnLong = 0;
        try {
            rtnLong = Long.parseLong(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnLong;
    }

    public long getLong(String key, long defaultValue) {
        String temp = this.getString(key, "0");
        long rtnLong = 0;
        try {
            rtnLong = Long.parseLong(temp);
        } catch (Exception e) {
            rtnLong = defaultValue;
        } finally {
        }
        return rtnLong;
    }

    public double getDouble(String key) {
        String temp = this.getString(key, "0");
        double rtnDouble = 0;
        try {
            rtnDouble = Double.parseDouble(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnDouble;
    }

    public double getDouble(String key, double defaultValue) {
        String temp = this.getString(key, "0");
        double rtnDouble = 0;
        try {
            rtnDouble = Double.parseDouble(temp);
        } catch (Exception e) {
            rtnDouble = defaultValue;
        } finally {
        }
        return rtnDouble;
    }

    public int getMoney(String key) {
        String temp = this.getString(key, "0");
        if (temp != null) {
            temp = temp.replaceAll(",", "");
        }
        int rtnInt = 0;
        try {
            rtnInt = Integer.parseInt(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnInt;
    }

    public long getLongMoney(String key) {
        String temp = this.getString(key, "0");
        if (temp != null) {
            temp = temp.replaceAll(",", "");
        }
        long rtnLong = 0;
        try {
            rtnLong = Long.parseLong(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnLong;
    }

    public double getDoubleMoney(String key) {
        String temp = this.getString(key, "0");
        if (temp != null) {
            temp = temp.replaceAll(",", "");
        }
        double rtnValue = 0;
        try {
            rtnValue = Double.parseDouble(temp);
        } catch (Exception e) {
        } finally {
        }
        return rtnValue;
    }

    public String getFormatMoney(String key) {
        long l_val = this.getLong(key);
        java.text.NumberFormat s_fmt = java.text.NumberFormat.getInstance();
        String s_tmp = s_fmt.format(l_val);
        return s_tmp;
    }

    public void setData(String key, Object object) {
        try {
            this.put(key + VMap.DATA, object);
        } catch (Exception e) {
        }
    }

    public Object getData(String key) {
        return this.get(key + VMap.DATA);
    }

    public String getDataString(String key) {
        return getString(key + VMap.DATA);
    }

    public String getDataString(String key, String defaultValue) {
        return getString(key + VMap.DATA, defaultValue);
    }

    public int getDataInt(String key) {
        return getInt(key + VMap.DATA);
    }

    public int getDataInt(String key, int defaultValue) {
        return getInt(key + VMap.DATA, defaultValue);
    }

    public long getDataLong(String key) {
        return getLong(key + VMap.DATA);
    }

    public long getDataLong(String key, long defaultValue) {
        return getLong(key + VMap.DATA, defaultValue);
    }

    public double getDataDouble(String key) {
        return getDouble(key + VMap.DATA);
    }

    public double getDataDouble(String key, double defaultValue) {
        return getDouble(key + VMap.DATA, defaultValue);
    }

    public int getDataMoney(String key) {
        return getMoney(key + VMap.DATA);
    }

    public long getDataLongMoney(String key) {
        return getLongMoney(key + VMap.DATA);
    }

    public String getDataFormatMoney(String key) {
        return getFormatMoney(key + VMap.DATA);
    }

    public String getRemoveString(String key, String removeWord) {
        String temp = this.getString(key, "");
        if (temp != null) {
            temp.replaceAll(removeWord, "");
        }
        return temp;
    }

    public String getFormList() {
        return getFormList(true);
    }

    public String getFormList(boolean isPageParamOnly) {
        StringBuffer rtnStr = new StringBuffer();
        Set<?> set = this.keySet();
        Object[] hmKeys = set.toArray();
        String key = "";
        Object value = null;
        for (int i = 0; i < hmKeys.length; i++) {
            key = (String) hmKeys[i];
            value = this.get(key);
            if (value == null)
                value = "";

            if (isPageParamOnly) {
                if (key.endsWith(VMap.REQUEST) || key.endsWith(VMap.SESSION) || key.endsWith(VMap.APPLICATION)
                        || key.endsWith(VMap.COOKIE) || key.endsWith(VMap.REQUESTURI) || key.endsWith(VMap.DATA)) {
                    continue;
                }
                if (value instanceof String == false && value instanceof String[] == false) {
                    continue;
                }
            }

            if (key != null) {
                if (value instanceof String) {
                    value = (String) value;
                } else if (value instanceof String[]) {
                    String[] arrValue = (String[]) value;
                    value = arrValue[0];
                }
                rtnStr.append("<input type='hidden' name='" + key + "' value=\"" + value + "\" > \n");
            }
        }
        return rtnStr.toString();
    }

    public String getFormArrayList() {
        return getFormArrayList(true);
    }

    public String getFormArrayList(boolean isPageParamOnly) {
        StringBuffer rtnStr = new StringBuffer();
        Set<?> set = this.keySet();
        Object[] hmKeys = set.toArray();
        String key = "";
        Object value = null;
        for (int i = 0; i < hmKeys.length; i++) {
            key = (String) hmKeys[i];
            value = this.get(key);
            if (value == null)
                value = "";

            if (isPageParamOnly) {
                if (key.endsWith(VMap.REQUEST) || key.endsWith(VMap.SESSION) || key.endsWith(VMap.APPLICATION)
                        || key.endsWith(VMap.COOKIE) || key.endsWith(VMap.REQUESTURI) || key.endsWith(VMap.DATA)) {
                    continue;
                }
                if (value instanceof String == false && value instanceof String[] == false) {
                    continue;
                }
            }

            if (key != null) {
                if (value instanceof String) {
                    value = (String) value;
                    rtnStr.append("<input type='hidden' name='" + key + "' value=\"" + value + "\" > \n");
                } else if (value instanceof String[]) {
                    String[] arrValue = (String[]) value;
                    for (int j = 0; j < arrValue.length; j++) {
                        value = arrValue[j];
                        rtnStr.append("<input type='hidden' name='" + key + "' value=\"" + value + "\" > \n");
                    }
                }
            }
        }
        return rtnStr.toString();
    }

    public VMap setDefaultValue(Object[] keys, String defaultValue) {
        if (keys != null) {
            for (int i = 0; i < keys.length; i++) {
                String key = (String) keys[i];
                this.initString(key, defaultValue);
            }
        }
        return this;
    }

    public VMap setDefaultValue(Object key, String defaultValue) {
        return setDefaultValue(new Object[] { key }, defaultValue);
    }

    public VMap setDefaultValue(String defaultValue) {
        Set<?> set = this.keySet();
        Object[] keys = set.toArray();
        return setDefaultValue(keys, defaultValue);
    }

    public VMap removeString(Object[] keys, String token) {
        if (keys != null && token != null && !token.equals("")) {
            for (int i = 0; i < keys.length; i++) {
                String key = (String) keys[i];
                String value = this.getString(key);
                this.put(key, value.replaceAll(token, ""));
            }
        }
        return this;
    }

    public VMap removeString(Object key, String defaultValue) {
        return removeString(new Object[] { key }, defaultValue);
    }

    public VMap removeString(String defaultValue) {
        Set<?> set = this.keySet();
        Object[] keys = set.toArray();
        return removeString(keys, defaultValue);
    }

    public VMap replaceString(Object[] keys, String fromStr, String toStr) {
        if (keys != null && fromStr != null && toStr != null) {
            if (!fromStr.equals("")) {
                for (int i = 0; i < keys.length; i++) {
                    String key = (String) keys[i];

                    if (key.endsWith(VMap.REQUEST) || key.endsWith(VMap.SESSION) || key.endsWith(VMap.APPLICATION)
                            || key.endsWith(VMap.COOKIE) || key.endsWith(VMap.REQUESTURI) || key.endsWith(VMap.DATA)) {
                        continue;
                    }

                    Object o = this.get(key);
                    if (o != null) {
                        if (o.getClass().isArray()) {
                            continue;
                        }
                    }
                    if (o instanceof String == false && o instanceof String[] == false) {
                        continue;
                    }

                    String value = this.getString(key);
                    this.put(key, value.replaceAll(fromStr, toStr));
                }
            }
        }
        return this;
    }

    public VMap replaceString(Object key, String fromStr, String toStr) {
        return replaceString(new Object[] { key }, fromStr, toStr);
    }

    public VMap replaceString(String fromStr, String toStr) {
        Set<?> set = this.keySet();
        Object[] keys = set.toArray();
        return replaceString(keys, fromStr, toStr);
    }

    public VMap trim(Object[] keys) {
        if (keys != null) {
            for (int i = 0; i < keys.length; i++) {
                String key = (String) keys[i];
                String value = this.getString(key).trim();
                this.put(key, value);
            }
        }
        return this;
    }

    public VMap trim(Object key) {
        return trim(new Object[] { key });
    }

    public VMap trim() {
        Set<?> set = this.keySet();
        Object[] keys = set.toArray();
        return trim(keys);
    }

    public VMap getVMap(Object[] keys) {
        VMap vmap = new VMap();
        if (keys != null) {
            for (int i = 0; i < keys.length; i++) {
                String key = (String) keys[i];
                String value = this.getString(key);
                vmap.put(key, value);
            }
        }
        return vmap;
    }

    public int getParamCount() {
        int iCount = 0;
        try {
            Set<?> set = this.keySet();
            Object[] keys = set.toArray();
            for (int i = 0; i < keys.length; i++) {
                String key = (String) keys[i];
                Object value = this.get(key);
                if (value == null)
                    value = "";
                if (key.endsWith(VMap.REQUEST) || key.endsWith(VMap.SESSION) || key.endsWith(VMap.APPLICATION)
                        || key.endsWith(VMap.COOKIE) || key.endsWith(VMap.REQUESTURI) || key.endsWith(VMap.DATA)) {
                    continue;
                }
                if (value instanceof String == false && value instanceof String[] == false) {
                    continue;
                }
                iCount++;
            }
        } catch (Exception e) {
        }
        return iCount;
    }

    public VMap getVMap(Object key) {
        String sKey = (String) key;
        if (sKey == null)
            sKey = "";

        String[] keys = null;
        if (sKey.indexOf(",") != -1) {
            sKey = sKey.replaceAll(" ", "");
            keys = sKey.split(",");
        } else {
            keys = new String[] { sKey };
        }
        return getVMap(keys);
    }

    public String getInfo(String vMapAttributeType) {
        String strAttributeType = vMapAttributeType;
        if (strAttributeType == null) {
            strAttributeType = "ALL";
        }
        else if (strAttributeType.equals("")) {
            strAttributeType = "PARAM";
        }

        StringBuffer rtnStr = new StringBuffer();
        rtnStr.append("\r\n======================== VMap[" + strAttributeType + "] ======================== \r\n");
        Set<?> set = this.keySet();
        Object[] hmKeys = set.toArray();
        String key = "";
        Object value = null;

        for (int i = 0; i < hmKeys.length; i++) {
            key = (String) hmKeys[i];

            value = this.get(key);
            if (value == null)
                value = "";

            if (vMapAttributeType == null) {
                //
            } else if (vMapAttributeType.equals("")) {
                if (key.endsWith(VMap.REQUEST) || key.endsWith(VMap.SESSION) || key.endsWith(VMap.APPLICATION)
                        || key.endsWith(VMap.COOKIE) || key.endsWith(VMap.REQUESTURI) || key.endsWith(VMap.DATA)) {
                    continue;
                }
                if (value instanceof String == false && value instanceof String[] == false) {
                    continue;
                }
            } else if (vMapAttributeType.equals(VMap.REQUEST)) {
                if (!key.endsWith(VMap.REQUEST)) {
                    continue;
                }
            } else if (vMapAttributeType.equals(VMap.SESSION)) {
                if (!key.endsWith(VMap.SESSION)) {
                    continue;
                }
            } else if (vMapAttributeType.equals(VMap.APPLICATION)) {
                if (!key.endsWith(VMap.APPLICATION)) {
                    continue;
                }
            } else if (vMapAttributeType.equals(VMap.COOKIE)) {
                if (!key.endsWith(VMap.COOKIE)) {
                    continue;
                }
            } else if (vMapAttributeType.equals(VMap.REQUESTURI)) {
                if (!key.endsWith(VMap.REQUESTURI)) {
                    continue;
                }
            } else if (vMapAttributeType.equals(VMap.DATA)) {
                if (!key.endsWith(VMap.DATA)) {
                    continue;
                }
            }

            Class<? extends Object> c = value.getClass();
            if (c.isArray()) {
                int length = Array.getLength(value);
                if (length == 0)
                    value = "";
                else if (length == 1) {
                    Object item = Array.get(value, 0);
                    if (item == null)
                        value = "";
                    else
                        value = item.toString();
                } else {
                    StringBuffer valueBuf = new StringBuffer();
                    valueBuf.append("[");
                    for (int j = 0; j < length; j++) {
                        Object item = Array.get(value, j);
                        if (item != null)
                            valueBuf.append(item.toString());
                        if (j < length - 1)
                            valueBuf.append(",");
                    }
                    valueBuf.append("]");
                    value = valueBuf.toString();
                }

            } else {
                if (value instanceof String) {
                    value = (String) value;
                } else {
                    value = value.toString();
                }
            }
            rtnStr.append(String.format("%30s", "[" + key + "]") + " : " + value + "\r\n");
        }
        return rtnStr.toString();
    }

    public String getInfo() {
        return getInfo("");
    }

    public String getInfoAll() {
        return getInfo(null);
    }

    public Object clone() {
        VMap vmap = new VMap();
        Set<?> set = this.keySet();
        Object[] hmKeys = set.toArray();
        String key = "";
        Object value = null;
        for (int i = 0; i < hmKeys.length; i++) {
            key = (String) hmKeys[i];

            value = this.get(key);
            if (value == null)
                value = "";

            if (key.endsWith(VMap.REQUEST) || key.endsWith(VMap.SESSION) || key.endsWith(VMap.APPLICATION)
                    || key.endsWith(VMap.COOKIE) || key.endsWith(VMap.REQUESTURI) || key.equals(VMap.REQUESTURI)
                    || key.endsWith(VMap.DATA)) {
                continue;
            }
            if (value instanceof String == false && value instanceof String[] == false) {
                continue;
            }

            vmap.put(key, value);
        }
        return vmap;
    }
}
