package com.changsin.webapp.common.vo;

import java.util.LinkedHashMap;

public class RowMap extends LinkedHashMap<Object, Object> {
    private static final long serialVersionUID = -5043805726258053659L;

    public Object put(Object key, Object value) {
        return super.put(key.toString().toLowerCase(), value);
    }
}
