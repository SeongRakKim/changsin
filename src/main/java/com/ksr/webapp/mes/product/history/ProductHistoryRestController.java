package com.ksr.webapp.mes.product.history;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class ProductHistoryRestController {

    @Autowired
    ProductHistoryService productHistoryService;

    @PostMapping("/mes/product/history/prodHistoryList")
    public ResponseEntity<List<Map<String, Object>>> prodList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> prodList = productHistoryService.prodHistoryList(vmap);

        return new ResponseEntity<>(prodList, HttpStatus.OK);
    }

}
