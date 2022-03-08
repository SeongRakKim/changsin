package com.ysis.webapp.mes.base.process;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ProcessService {

    @Autowired CommonDAO commonDAO;
    @Autowired ProcessDAO processDAO;

    public List<Map<String, Object>> procList(VMap vmap) throws Exception {
        return processDAO.procList(vmap);
    }

    public Map<String, Object> procOne(VMap vmap) throws Exception {
        return processDAO.procOne(vmap);
    }

    public Map<String, Object> procOverlap(VMap vmap) throws Exception {
        return processDAO.procOverlap(vmap);
    }

    @Transactional
    public int procRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "PROC");
        vmap.put("proc_cd", CommonUtils.isNotEmpty(vmap.getString("proc_cd")) ? vmap.getString("proc_cd") : commonDAO.getTablePrimaryCode(vmap));

        return processDAO.procRegistModify(vmap);
    }

    public int procPackDelete(VMap vmap) throws Exception {
        return processDAO.procPackDelete(vmap);
    }

}
