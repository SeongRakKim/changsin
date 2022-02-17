package com.changsin.webapp.common.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashMap;

@Getter
@Setter
public class RowMap extends LinkedHashMap<Object, Object> {
    private static final long serialVersionUID = -5043805726258053659L;

    public Object put(Object key, Object value) {
        return super.put(key.toString().toLowerCase(), value);
    }
}
