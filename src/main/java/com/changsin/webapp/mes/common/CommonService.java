package com.changsin.webapp.mes.common;

import com.changsin.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommonService {

    @Autowired CommonDAO commonDAO;

    public List<Map<String, Object>> baseDetailList(VMap vmap) throws Exception {
        return commonDAO.baseDetailList(vmap);
    }

}
