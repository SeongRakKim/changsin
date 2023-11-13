package com.ksr.webapp.mes.base.sensor;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class SensorService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    SensorDAO sensorDAO;

    public List<Map<String, Object>> snsrList(VMap vmap) throws Exception {
        return sensorDAO.snsrList(vmap);
    }

    public Map<String, Object> snsrOne(VMap vmap) throws Exception {
        return sensorDAO.snsrOne(vmap);
    }

    public Map<String, Object> snsrOne2(VMap vmap) throws Exception {
        return sensorDAO.snsrOne2(vmap);
    }

    public Map<String, Object> snsrOverlap(VMap vmap) throws Exception {
        return sensorDAO.snsrOverlap(vmap);
    }

    @Transactional
    public int snsrRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "SNSR");
        vmap.put("snsr_cd", CommonUtils.isNotEmpty(vmap.getString("snsr_cd")) ? vmap.getString("snsr_cd") : commonDAO.getTablePrimaryCode(vmap));

        return sensorDAO.snsrRegistModify(vmap);
    }

    public int snsrPackDelete(VMap vmap) throws Exception {
        return sensorDAO.snsrPackDelete(vmap);
    }

}
