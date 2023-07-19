package com.ksr.webapp.mes.base.product;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ProductService {

    @Autowired CommonDAO commonDAO;
    @Autowired ProductDAO productDAO;

    public List<Map<String, Object>> prodList(VMap vmap) throws Exception {
        return productDAO.prodList(vmap);
    }

    public Map<String, Object> prodOne(VMap vmap) throws Exception {
        return productDAO.prodOne(vmap);
    }

    public Map<String, Object> createProdLotNo(VMap vmap) throws Exception {
        return productDAO.createProdLotNo(vmap);
    }

    @Transactional
    public int prodLotRegistModify(VMap vmap) throws Exception {
        return productDAO.prodLotRegistModify(vmap);
    }

    public int prodLotDelete(VMap vmap) throws Exception {
        return productDAO.prodLotDelete(vmap);
    }

    public Map<String, Object> prodOverlap(VMap vmap) throws Exception {
        return productDAO.prodOverlap(vmap);
    }

    public List<Map<String, Object>> prodOverlap2(VMap vmap) throws Exception {
        return productDAO.prodOverlap2(vmap);
    }

    public List<Map<String, Object>> prodOverlap3(VMap vmap) throws Exception {
        return productDAO.prodOverlap3(vmap);
    }

    public List<Map<String, Object>> prodOverlap4(VMap vmap) throws Exception {
        return productDAO.prodOverlap4(vmap);
    }

    public List<Map<String, Object>> prodOverlap5(VMap vmap) throws Exception {
        return productDAO.prodOverlap5(vmap);
    }

    @Transactional
    public int prodRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "PROD");
        vmap.put("prod_cd", CommonUtils.isNotEmpty(vmap.getString("prod_cd")) ? vmap.getString("prod_cd") : commonDAO.getTablePrimaryCode(vmap));

        return productDAO.prodRegistModify(vmap);
    }

    public int prodPackDelete(VMap vmap) throws Exception {

        productDAO.prodProcPackDelete(vmap);
        productDAO.prodBomPackDelete(vmap);

        return productDAO.prodPackDelete(vmap);
    }

    public List<Map<String, Object>> prodProcList(VMap vmap) throws Exception {
        return productDAO.prodProcList(vmap);
    }

    @Transactional
    public int prodProcRegistModify(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> prod_proc_seq =  (List<String>)vmap.get("ary_prod_proc_seq");
        List<String> prod_proc_cd = (List<String>)vmap.get("ary_prod_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> prod_proc_min = (List<String>)vmap.get("ary_prod_proc_min");
        List<String> prod_proc_notice = (List<String>)vmap.get("ary_prod_proc_notice");

        vmap.put("table_type", "PRPC");

        for(int i=0; i<prod_proc_seq.size(); i++) {
            VMap prodProcMap = new VMap();

            prodProcMap.put("fact_cd", vmap.getString("fact_cd"));
            prodProcMap.put("prod_cd", vmap.getString("prod_cd"));
            prodProcMap.put("prod_proc_seq", prod_proc_seq.get(i));
            prodProcMap.put("prod_proc_cd", CommonUtils.isNotEmpty(prod_proc_cd.get(i)) ? prod_proc_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            prodProcMap.put("proc_cd", proc_cd.get(i));
            prodProcMap.put("prod_proc_min", prod_proc_min.get(i));
            prodProcMap.put("prod_proc_notice", prod_proc_notice.get(i));
            prodProcMap.put("u_cd", vmap.getString("u_cd"));

            productDAO.prodProcRegistModify(prodProcMap);

            returnCnt++;
        }

        return returnCnt;
    }

    public int prodProcDelete(VMap vmap) throws Exception {
        return productDAO.prodProcDelete(vmap);
    }

    public List<Map<String, Object>> prodBomList(VMap vmap) throws Exception {
        return productDAO.prodBomList(vmap);
    }

    @Transactional
    public int prodBomRegistModify(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> prod_bom_cd =  (List<String>)vmap.get("ary_prod_bom_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> prod_ja_cd = (List<String>)vmap.get("ary_prod_ja_cd");
        List<String> prod_bom_cnt = (List<String>)vmap.get("ary_prod_bom_cnt");
        List<String> prod_bom_notice = (List<String>)vmap.get("ary_prod_bom_notice");

        vmap.put("table_type", "PRBM");

        for(int i=0; i<prod_bom_cd.size(); i++) {
            VMap prodBomMap = new VMap();

            prodBomMap.put("fact_cd", vmap.getString("fact_cd"));
            prodBomMap.put("prod_cd", vmap.getString("prod_cd"));
            prodBomMap.put("prod_bom_cd", CommonUtils.isNotEmpty(prod_bom_cd.get(i)) ? prod_bom_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            prodBomMap.put("proc_cd", proc_cd.get(i));
            prodBomMap.put("prod_ja_cd", prod_ja_cd.get(i));
            prodBomMap.put("prod_bom_cnt", prod_bom_cnt.get(i));
            prodBomMap.put("prod_bom_notice", prod_bom_notice.get(i));
            prodBomMap.put("u_cd", vmap.getString("u_cd"));

            productDAO.prodBomRegistModify(prodBomMap);

            returnCnt++;
        }

        return returnCnt;
    }

    public int prodBomDelete(VMap vmap) throws Exception {
        return productDAO.prodBomDelete(vmap);
    }

    public int prodStockCntModify(VMap vmap) throws Exception {
        return productDAO.prodStockCntModify(vmap);
    }

    public List<Map<String, Object>> prodLotList(VMap vmap) throws Exception {
        return productDAO.prodLotList(vmap);
    }

}
