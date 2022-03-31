package com.ksr.webapp.mes.base.material;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class MaterialService {

    @Autowired CommonDAO commonDAO;
    @Autowired MaterialDAO materialDAO;

    public List<Map<String, Object>> mateList(VMap vmap) throws Exception {
        return materialDAO.mateList(vmap);
    }

    public Map<String, Object> mateOne(VMap vmap) throws Exception {
        return materialDAO.mateOne(vmap);
    }

    public Map<String, Object> mateOverlap(VMap vmap) throws Exception {
        return materialDAO.mateOverlap(vmap);
    }

    public List<Map<String, Object>> mateOverlap2(VMap vmap) throws Exception {
        return materialDAO.mateOverlap2(vmap);
    }

    @Transactional
    public int mateRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "MATE");
        vmap.put("mate_cd", CommonUtils.isNotEmpty(vmap.getString("mate_cd")) ? vmap.getString("mate_cd") : commonDAO.getTablePrimaryCode(vmap));

        return materialDAO.mateRegistModify(vmap);
    }

    public int matePackDelete(VMap vmap) throws Exception {
        return materialDAO.matePackDelete(vmap);
    }

    public int mateStockCntModify(VMap vmap) throws Exception {
        return materialDAO.mateStockCntModify(vmap);
    }

}
