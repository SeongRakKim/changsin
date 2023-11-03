package com.ksr.webapp.mes.base.equipment;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class EquipmentService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    EquipmentDAO equipmentDAO;

    public List<Map<String, Object>> equList(VMap vmap) throws Exception {
        return equipmentDAO.equList(vmap);
    }

    public Map<String, Object> equOne(VMap vmap) throws Exception {
        return equipmentDAO.equOne(vmap);
    }

    public Map<String, Object> equOverlap(VMap vmap) throws Exception {
        return equipmentDAO.equOverlap(vmap);
    }

    @Transactional
    public int equRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "EQU");
        vmap.put("equ_cd", CommonUtils.isNotEmpty(vmap.getString("equ_cd")) ? vmap.getString("equ_cd") : commonDAO.getTablePrimaryCode(vmap));

        return equipmentDAO.equRegistModify(vmap);
    }

    public int equPackDelete(VMap vmap) throws Exception {
        return equipmentDAO.equPackDelete(vmap);
    }

    public List<Map<String, Object>> equipmentInterfaceData(VMap vmap) throws Exception {
        return equipmentDAO.equipmentInterfaceData(vmap);
    }

    public List<Map<String, Object>> equRepairList(VMap vmap) throws Exception {
        return equipmentDAO.equRepairList(vmap);
    }

    public Map<String, Object> equRepairOne(VMap vmap) throws Exception {
        return equipmentDAO.equRepairOne(vmap);
    }

    @Transactional
    public int equRepairRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "REPAIR");
        vmap.put("equ_repair_cd", CommonUtils.isNotEmpty(vmap.getString("equ_repair_cd")) ? vmap.getString("equ_repair_cd") : commonDAO.getTablePrimaryCode(vmap));

        return equipmentDAO.equRepairRegistModify(vmap);
    }

    public int equRepairPackDelete(VMap vmap) throws Exception {
        return equipmentDAO.equRepairPackDelete(vmap);
    }

}
