package com.ysis.webapp.mes.base.company;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class CompanyService {

    @Autowired CommonDAO commonDAO;
    @Autowired CompanyDAO companyDAO;

    public List<Map<String, Object>> compList(VMap vmap) throws Exception {
        return companyDAO.compList(vmap);
    }

    public Map<String, Object> compOne(VMap vmap) throws Exception {
        return companyDAO.compOne(vmap);
    }

    public Map<String, Object> compOverlap(VMap vmap) throws Exception {
        return companyDAO.compOverlap(vmap);
    }

    public List<Map<String, Object>> compCompletOverlap(VMap vmap) throws Exception {
        return companyDAO.compCompletOverlap(vmap);
    }

    @Transactional
    public int compRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "COMP");
        vmap.put("comp_cd", CommonUtils.isNotEmpty(vmap.getString("comp_cd")) ? vmap.getString("comp_cd") : commonDAO.getTablePrimaryCode(vmap));

        return companyDAO.compRegistModify(vmap);
    }

    public int compPackDelete(VMap vmap) throws Exception {
        return companyDAO.compPackDelete(vmap);
    }

}
