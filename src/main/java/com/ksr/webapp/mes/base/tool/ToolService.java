package com.ksr.webapp.mes.base.tool;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ToolService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    ToolDAO toolDAO;

    public List<Map<String, Object>> toolList(VMap vmap) throws Exception {
        return toolDAO.toolList(vmap);
    }

    public Map<String, Object> toolOne(VMap vmap) throws Exception {
        return toolDAO.toolOne(vmap);
    }

    public Map<String, Object> toolOverlap(VMap vmap) throws Exception {
        return toolDAO.toolOverlap(vmap);
    }

    @Transactional
    public int toolRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "TOOL");
        vmap.put("tool_cd", CommonUtils.isNotEmpty(vmap.getString("tool_cd")) ? vmap.getString("tool_cd") : commonDAO.getTablePrimaryCode(vmap));

        return toolDAO.toolRegistModify(vmap);
    }

    public int toolPackDelete(VMap vmap) throws Exception {
        return toolDAO.toolPackDelete(vmap);
    }

}
