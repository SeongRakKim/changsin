package com.ysis.webapp.mes.sales.shipment;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SalesShipmentDAO extends MapperDAO {

    private static String mapperName = "mes.sales.shipment";

    public List<Map<String, Object>> shipList(VMap vMap) throws Exception {
        return selectList(mapperName + ".shipList", vMap.getMap());
    }

    public Map<String, Object> shipOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".shipOne", vMap.getMap());
    }

    public List<Map<String, Object>> salesShipmentDetailtList(VMap vMap) throws Exception {
        return selectList(mapperName + ".salesShipmentDetailtList", vMap.getMap());
    }

    public int salesShipmentDetailRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".salesShipmentDetailRegistModify", vmap.getMap());
    }

    public int salesShipmentDetailDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".salesShipmentDetailDelete", vmap.getMap());
    }

    public void salesShipmentStateModify(VMap vmap) throws Exception {
        update(mapperName + ".salesShipmentStateModify", vmap.getMap());
    }

}
