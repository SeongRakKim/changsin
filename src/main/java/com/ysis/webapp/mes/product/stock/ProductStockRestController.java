package com.ysis.webapp.mes.product.stock;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProductStockRestController {

    @Autowired
    ProductStockService productStockService;

    @PostMapping("/mes/product/stock/prodStockList")
    public ResponseEntity<List<Map<String, Object>>> prodList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> prodList = productStockService.prodStockList(vmap);

        return new ResponseEntity<>(prodList, HttpStatus.OK);
    }

}
