package com.ksr.webapp.common.config;

public class BaseCodeItem
{
    public static final String API_KEY = "$5$API$oSxSirazOfeKdU16pm/tNPbU3Xrr74Jkwyk.9Rl.44C";

    public static final String ORDER_REGIST = "01";
    public static final String ORDER_CANCLE = "02";

    public static final String PRODUCTION_READY = "10";
    public static final String PRODUCTION_ING = "11";
    public static final String PRODUCTION_COMPLETE = "12";
    public static final String PRODUCTION_STOP = "13";

    public static final String SHIP_READY = "20";
    public static final String SHIP_ING = "21";
    public static final String SHIP_COMPLETE = "22";
    public static final String SHIP_STOP = "23";

    public static final String PURCHASE_READY = "30";
    public static final String PURCHASE_COMPELTE = "31";

    public static final String INOUT_PRODUCTION = "01";
    public static final String INOUT_SHIP = "02";
    public static final String INOUT_INPUT = "03";
    public static final String INOUT_DELETE = "04";
    public static final String INOUT_PURCHASE = "05";
    public static final String INOUT_ETC = "99";

    public static final String SHIP_REGIST = "제품출하에 의한 재고차감";
    public static final String SHIP_MODIFY = "제품출하에 수량 수정에 의한 재고보정";
    public static final String SHIP_DELETE = "제품출하 삭제에 의한 재고증가";

    public static final String PLAN_RESULT_REGIST = "생산실적 등록에 의한 재고증가";
    public static final String PLAN_RESULT_MODIFY = "생산실적 생산량 수정에 의한 재고보정";
    public static final String PLAN_RESULT_DELETE = "생산실적 삭제에 의한 재고차감";

    public static final String PLAN_INPUT_REGIST = "생산투입에 의한 재고차감";
    public static final String PLAN_INPUT_DELETE = "생산투입 데이터 삭제에 의한 재고증가";

    public static final String PURCHASE_REGIST = "자재입고에 의한 재고증가";
    public static final String PURCHASE_DELETE = "자재입고 데이터 삭제에 의한 재고차감";

}
