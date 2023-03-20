package com.ksr.webapp.common.retrofit;

import com.ksr.webapp.common.util.ClientUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import retrofit2.Call;
import retrofit2.Response;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Service
public class RetrofitService {

    private static final String CONTENT_TYPE = "application/json";

    @Autowired
    private RestInterface restInterface;

    public void apiTest(VMap vmap) throws Exception {

        Map<String, Object> json = null;

        json.put("crtfcKey", "$5$API$oSxSirazOfeKdU16pm/tNPbU3Xrr74Jkwyk.9Rl.44C");
        json.put("logDt", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date()));
        json.put("useSe", "접속");
        json.put("sysUser", "CHANGSHIN");
        json.put("conectIp", ClientUtils.getClientIp());
        json.put("dataUsgqty", "0");

        Call<Object> call = restInterface.apiTest(CONTENT_TYPE, vmap);
        Response<Object> response = call.execute();
    }

}
