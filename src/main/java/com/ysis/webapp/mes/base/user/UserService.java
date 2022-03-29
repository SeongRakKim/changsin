package com.ysis.webapp.mes.base.user;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.product.ProductDAO;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    UserDAO userDAO;


    public List<Map<String, Object>> userList(VMap vmap) throws Exception {
        return userDAO.userList(vmap);
    }

    public Map<String, Object> planOne(VMap vmap) throws Exception {
        return userDAO.planOne(vmap);
    }

    public Map<String, Object> planOverlap(VMap vmap) throws Exception {
        return userDAO.planOverlap(vmap);
    }

    @Transactional
    public int planRegist(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> plan_cd =  (List<String>)vmap.get("ary_plan_cd");
        List<String> comp_cd = (List<String>)vmap.get("ary_comp_cd");
        List<String> prod_cd = (List<String>)vmap.get("ary_prod_cd");
        List<String> plan_stdt = (List<String>)vmap.get("ary_plan_stdt");
        List<String> plan_eddt = (List<String>)vmap.get("ary_plan_eddt");
        List<String> plan_cnt = (List<String>)vmap.get("ary_plan_cnt");
        List<String> plan_no = (List<String>)vmap.get("ary_plan_no");
        List<String> plan_notice = (List<String>)vmap.get("ary_plan_notice");

//        for(int i=0; i<plan_cd.size(); i++)
//        {
//            // 생산계획 데이터
//            vmap.put("table_type", "PRPL");
//            vmap.put("column_type", "WK");
//            VMap planMap = new VMap();
//
//            planMap.put("fact_cd", vmap.getString("fact_cd"));
//            planMap.put("plan_cd", CommonUtils.isNotEmpty(plan_cd.get(i)) ? plan_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
//            planMap.put("comp_cd", comp_cd.get(i));
//            planMap.put("prod_cd", prod_cd.get(i));
//            planMap.put("plan_stdt", plan_stdt.get(i));
//            planMap.put("plan_eddt", plan_eddt.get(i));
//            planMap.put("plan_cnt", plan_cnt.get(i));
//            planMap.put("plan_no", CommonUtils.isNotEmpty(plan_no.get(i)) ? plan_no.get(i) : commonDAO.getTableRandomKey(vmap));
//            planMap.put("plan_notice", plan_notice.get(i));
//            planMap.put("u_cd", vmap.getString("u_cd"));
//
//            userDAO.planRegist(planMap);
//
//            // 계획-공정 (제품-공정 데이터 생성)
//            ArrayList<Map<String, Object>> prodProcList = (ArrayList)productDAO.prodProcList(planMap);
//            int j=0;
//            for (Map result : prodProcList)
//            {
//                VMap planProcMap = new VMap();
//
//                vmap.put("column_type", "PLPC");
//                planProcMap.put("fact_cd", vmap.getString("fact_cd"));
//                planProcMap.put("plan_cd", planMap.getString("plan_cd"));
//                planProcMap.put("plan_proc_cd", commonDAO.getTablePrimaryCode(vmap));
//                planProcMap.put("proc_cd", result.get("proc_cd"));
//                planProcMap.put("plan_proc_seq", ++j);
//                planProcMap.put("plan_proc_last_yn", (j == prodProcList.size() ? "Y" : "N"));
//
//                userDAO.planProcRegist(planProcMap);
//            }
//
//            returnCnt++;
//        }

        return returnCnt;
    }

    @Transactional
    public int planModify(VMap vmap) throws Exception {

        // 생산지시 - 공정 변경
        List<String> plan_proc_cd =  (List<String>)vmap.get("ary_plan_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> plan_proc_notice = (List<String>)vmap.get("ary_plan_proc_notice");

        for(int i=0; i<plan_proc_cd.size(); i++)
        {
            VMap planProcMap = new VMap();

            planProcMap.put("plan_proc_cd", plan_proc_cd.get(i));
            planProcMap.put("plan_proc_notice", plan_proc_notice.get(i));

            userDAO.planProcModify(planProcMap);
        }

        return userDAO.planModify(vmap);
    }

    public int planPackDelete(VMap vmap) throws Exception {
        return userDAO.planPackDelete(vmap);
    }

    public List<Map<String, Object>> planProcList(VMap vmap) throws Exception {
        return userDAO.planProcList(vmap);
    }

    public int planProcDelete(VMap vmap) throws Exception {
        return userDAO.planProcDelete(vmap);
    }

}