package com.ysis.webapp.mes.production.result;

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
public class ProductionResultService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    ProductionResultDAO productionResultDAO;
    @Autowired
    ProductDAO productDAO;

    public List<Map<String, Object>> planProcessList(VMap vmap) throws Exception {
        return productionResultDAO.planProcessList(vmap);
    }

    public Map<String, Object> planProcessOne(VMap vmap) throws Exception {
        return productionResultDAO.planProcessOne(vmap);
    }

    public Map<String, Object> resultOverlap(VMap vmap) throws Exception {
        return productionResultDAO.resultOverlap(vmap);
    }

    @Transactional
    public int resultRegist(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> result_cd =  (List<String>)vmap.get("ary_result_cd");
        List<String> comp_cd = (List<String>)vmap.get("ary_comp_cd");
        List<String> prod_cd = (List<String>)vmap.get("ary_prod_cd");
        List<String> result_stdt = (List<String>)vmap.get("ary_result_stdt");
        List<String> result_eddt = (List<String>)vmap.get("ary_result_eddt");
        List<String> result_cnt = (List<String>)vmap.get("ary_result_cnt");
        List<String> result_no = (List<String>)vmap.get("ary_result_no");
        List<String> result_notice = (List<String>)vmap.get("ary_result_notice");

        for(int i=0; i<result_cd.size(); i++)
        {
            // 생산계획 데이터
            vmap.put("table_type", "PRPL");
            vmap.put("column_type", "WK");
            VMap resultMap = new VMap();

            resultMap.put("fact_cd", vmap.getString("fact_cd"));
            resultMap.put("result_cd", CommonUtils.isNotEmpty(result_cd.get(i)) ? result_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            resultMap.put("comp_cd", comp_cd.get(i));
            resultMap.put("prod_cd", prod_cd.get(i));
            resultMap.put("result_stdt", result_stdt.get(i));
            resultMap.put("result_eddt", result_eddt.get(i));
            resultMap.put("result_cnt", result_cnt.get(i));
            resultMap.put("result_no", CommonUtils.isNotEmpty(result_no.get(i)) ? result_no.get(i) : commonDAO.getTableRandomKey(vmap));
            resultMap.put("result_notice", result_notice.get(i));
            resultMap.put("u_cd", vmap.getString("u_cd"));

            productionResultDAO.resultRegist(resultMap);

            // 계획-공정 (제품-공정 데이터 생성)
            ArrayList<Map<String, Object>> prodProcList = (ArrayList)productDAO.prodProcList(resultMap);
            int j=0;
            for (Map result : prodProcList)
            {
                VMap resultProcMap = new VMap();

                vmap.put("column_type", "PLPC");
                resultProcMap.put("fact_cd", vmap.getString("fact_cd"));
                resultProcMap.put("result_cd", resultMap.getString("result_cd"));
                resultProcMap.put("result_proc_cd", commonDAO.getTablePrimaryCode(vmap));
                resultProcMap.put("proc_cd", result.get("proc_cd"));
                resultProcMap.put("result_proc_seq", ++j);
                resultProcMap.put("result_proc_last_yn", (j == prodProcList.size() ? "Y" : "N"));

                productionResultDAO.resultProcRegist(resultProcMap);
            }

            returnCnt++;
        }

        return returnCnt;
    }

    @Transactional
    public int resultModify(VMap vmap) throws Exception {

        // 생산지시 - 공정 변경
        List<String> result_proc_cd =  (List<String>)vmap.get("ary_result_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> result_proc_notice = (List<String>)vmap.get("ary_result_proc_notice");

        for(int i=0; i<result_proc_cd.size(); i++)
        {
            VMap resultProcMap = new VMap();

            resultProcMap.put("result_proc_cd", result_proc_cd.get(i));
            resultProcMap.put("result_proc_notice", result_proc_notice.get(i));

            productionResultDAO.resultProcModify(resultProcMap);
        }

        return productionResultDAO.resultModify(vmap);
    }

    public int resultPackDelete(VMap vmap) throws Exception {
        return productionResultDAO.resultPackDelete(vmap);
    }

    public List<Map<String, Object>> resultProcList(VMap vmap) throws Exception {
        return productionResultDAO.resultProcList(vmap);
    }

    public int resultProcDelete(VMap vmap) throws Exception {
        return productionResultDAO.resultProcDelete(vmap);
    }

}
