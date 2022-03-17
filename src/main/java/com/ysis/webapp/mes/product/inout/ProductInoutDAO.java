package com.ysis.webapp.mes.product.inout;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductInoutDAO extends MapperDAO {

    private static String mapperName = "mes.product.inout";

    public List<Map<String, Object>> productInoutList(VMap vMap) throws Exception {
        return selectList(mapperName + ".productInoutList", vMap.getMap());
    }

    public Map<String, Object> productInoutOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".productInoutOne", vMap.getMap());
    }

    public int productInoutRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".productInoutRegist", vmap.getMap());
    }

}
