package com.ksr.webapp.mes.material.part;

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
public class MaterialPartRestController {

    @Autowired
    MaterialPartService materialPartService;

    @PostMapping("/mes/material/part/prodPartList")
    public ResponseEntity<List<Map<String, Object>>> prodList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> prodList = materialPartService.prodPartList(vmap);

        return new ResponseEntity<>(prodList, HttpStatus.OK);
    }

}
