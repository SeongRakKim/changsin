package com.ysis.webapp.common.config;

public class BaseCodeItem
{
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

    public static final String INOUT_PRODUCTION = "01";
    public static final String INOUT_SHIP = "02";
    public static final String INOUT_INPUT = "03";
    public static final String INOUT_DELETE = "04";
    public static final String INOUT_ETC = "99";

    public static final String PLAN_RESULT_REGIST = "생산실적 등록에 의한 재고증가";
    public static final String PLAN_RESULT_MODIFY = "생산실적 생산량 수정에 의한 재고보정";
    public static final String PLAN_RESULT_DELETE = "생산실적 삭제에 의한 재고차감";

    public static final String PLAN_INPUT_REGIST = "생산투입에 의한 재고차감";
    public static final String PLAN_INPUT_MODIFY = "생산투입 데이터 삭제에 의한 재고증가";

}
