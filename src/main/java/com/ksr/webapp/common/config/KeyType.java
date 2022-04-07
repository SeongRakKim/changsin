package com.ksr.webapp.common.config;

public enum KeyType {

    DF_FACT_CD("1000");

    private final String fact_cd;

    KeyType(String fact_cd) {
        this.fact_cd = fact_cd;
    }

    public String getFact_cd() {
        return fact_cd;
    }
}
