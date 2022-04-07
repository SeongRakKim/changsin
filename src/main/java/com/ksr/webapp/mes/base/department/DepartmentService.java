package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class DepartmentService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    DepartmentDAO departmentDAO;

    public List<Map<String, Object>> deptList(VMap vmap) throws Exception {
        return departmentDAO.deptList(vmap);
    }

    public Map<String, Object> deptOne(VMap vmap) throws Exception {
        return departmentDAO.deptOne(vmap);
    }

    public Map<String, Object> deptOverlap(VMap vmap) throws Exception {
        return departmentDAO.deptOverlap(vmap);
    }

    @Transactional
    public int deptRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "PROC");
        vmap.put("dept_cd", CommonUtils.isNotEmpty(vmap.getString("dept_cd")) ? vmap.getString("dept_cd") : commonDAO.getTablePrimaryCode(vmap));

        return departmentDAO.deptRegistModify(vmap);
    }

    public int deptPackDelete(VMap vmap) throws Exception {
        return departmentDAO.deptPackDelete(vmap);
    }

}
