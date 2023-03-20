package com.ksr.webapp.common.retrofit;

import com.ksr.webapp.common.vo.VMap;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.POST;

import java.util.Map;

public interface RestInterface {

    @POST("sendLogDataJSON.do")
    Call<Object> apiTest(@Header("content-type") String contectType, @Body VMap params);

}