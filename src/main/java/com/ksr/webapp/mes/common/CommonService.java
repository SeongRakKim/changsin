package com.ksr.webapp.mes.common;

import com.ksr.webapp.common.config.BaseCodeItem;
import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class CommonService {

    @Autowired CommonDAO commonDAO;

    public String getTablePrimaryCode(VMap vmap) throws Exception {
        return commonDAO.getTablePrimaryCode(vmap);
    }

    public List<Map<String, Object>> baseList(VMap vmap) throws Exception {
        return commonDAO.baseList(vmap);
    }

    public Map<String, Object> baseOne(VMap vmap) throws Exception {
        return commonDAO.baseOne(vmap);
    }

    public List<Map<String, Object>> baseDetailList(VMap vmap) throws Exception {
        return commonDAO.baseDetailList(vmap);
    }

    @Transactional
    public int baseCodeDetailRegistModify(VMap vmap) throws Exception
    {
        int returnCnt = 0;

        vmap.put("column_type", "BS");

        List<String> base_detail_cd =  (List<String>)vmap.get("ary_base_detail_cd");
        List<String> base_detail_nm = (List<String>)vmap.get("ary_base_detail_nm");

        for(int i=0; i<base_detail_cd.size(); i++) {

            // 납품내역 수정
            VMap shipMap = new VMap();
            shipMap.put("fact_cd", vmap.getString("fact_cd"));
            shipMap.put("base_cd", vmap.getString("base_cd"));
            shipMap.put("base_detail_cd", CommonUtils.isNotEmpty(base_detail_cd.get(i)) ? base_detail_cd.get(i) : commonDAO.getTableRandomKey(vmap));
            shipMap.put("base_detail_nm", base_detail_nm.get(i));

            returnCnt += commonDAO.baseCodeDetailRegistModify(shipMap);
        }

        return returnCnt;
    }

    public int baseCodeDetailDelete(VMap vmap) throws Exception {
        return commonDAO.baseCodeDetailDelete(vmap);
    }

}
