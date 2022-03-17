package com.ysis.webapp.mes.material.inout;

import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.material.MaterialDAO;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class MaterialInoutService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    MaterialInoutDAO materialInoutDAO;

    @Autowired
    MaterialDAO materialDAO;

    public List<Map<String, Object>> materialInoutList(VMap vmap) throws Exception {
        return materialInoutDAO.materialInoutList(vmap);
    }

    public Map<String, Object> materialInoutOne(VMap vmap) throws Exception {
        return materialInoutDAO.materialInoutOne(vmap);
    }

    @Transactional
    public void materialStockModify(VMap vmap, String inout_type, String inout_item, String mate_cd,
                                    double inout_cnt, double bom_cnt, String inout_crcd, String inout_msg) throws Exception {
        // 제품 정보 가져오기
        VMap prodMap = new VMap();
        prodMap.put("mate_cd", mate_cd);
        Map<String, Object> mate = materialDAO.mateOne(vmap);

        // 입출고이력 생성
        vmap.put("table_type", "MINOUT");
        String inout_cd = commonDAO.getTablePrimaryCode(vmap);

        VMap inout = new VMap();
        inout.put("fact_cd", vmap.getString("fact_cd"));
        inout.put("inout_cd", inout_cd);
        inout.put("inout_type", inout_type);
        inout.put("inout_item", inout_item);
        inout.put("mate_cd", mate_cd);
        inout.put("inout_cnt", inout_cnt);
        inout.put("inout_crcd", inout_crcd);
        inout.put("inout_dt", null);
        inout.put("prod_stock_cnt", mate.get("mate_stock_cnt"));
        inout.put("inout_msg", inout_msg);

        materialInoutDAO.materialInoutRegist(inout);

        // 제품 재고 조정
        vmap.put("inout_type", inout_type);
        vmap.put("prod_stock_cnt", inout_cnt);

        materialDAO.mateStockCntModify(vmap);

    }

    @Transactional
    public void resultModify(VMap vmap) throws Exception {

    }

}
