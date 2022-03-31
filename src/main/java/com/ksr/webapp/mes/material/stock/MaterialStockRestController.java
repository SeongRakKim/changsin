package com.ksr.webapp.mes.material.stock;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class MaterialStockRestController {

    @Autowired
    MaterialStockService materialStockService;

    @PostMapping("/mes/material/sotck/mateStockList")
    public ResponseEntity<List<Map<String, Object>>> mateStockList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> mateList = materialStockService.mateStockList(vmap);

        return new ResponseEntity<>(mateList, HttpStatus.OK);
    }

}
