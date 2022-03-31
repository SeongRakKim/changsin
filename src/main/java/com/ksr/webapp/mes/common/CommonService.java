package com.ksr.webapp.mes.common;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommonService {

    @Autowired CommonDAO commonDAO;

    public String getTablePrimaryCode(VMap vmap) throws Exception {
        return commonDAO.getTablePrimaryCode(vmap);
    }

    public List<Map<String, Object>> baseDetailList(VMap vmap) throws Exception {
        return commonDAO.baseDetailList(vmap);
    }

}
