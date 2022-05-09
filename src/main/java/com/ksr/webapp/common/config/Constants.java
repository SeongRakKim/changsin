package com.ksr.webapp.common.config;

public final class Constants {

    private  final static String[] STATIC_RES = {
            "/bamburgh"
           ,"/common"
           ,"/img"
           ,"/plugin"
           ,"/sbadmin"
    };

    public final static String[] STATIOC_RESOUCREC_URL_PATTERNS = {
            STATIC_RES[0]+"/**"
           ,STATIC_RES[1]+"/**"
           ,STATIC_RES[2]+"/**"
           ,STATIC_RES[3]+"/**"
           ,STATIC_RES[4]+"/**"
    };

}
