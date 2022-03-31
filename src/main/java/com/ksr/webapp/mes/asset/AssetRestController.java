package com.ksr.webapp.mes.asset;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class AssetRestController {

    @Autowired
    AssetService assetService;

    @PostMapping("/mes/asset/part/assetPartList")
    public ResponseEntity<List<Map<String, Object>>> assetPartList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = assetService.assetPartList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @GetMapping("/mes/asset/part/productInoutOne/{plan_cd}/{plan_proc_cd}")
    public ResponseEntity<Map<String, Object>> productInoutOne(VMap vmap, @PathVariable("plan_cd") String plan_cd, @PathVariable("plan_proc_cd") String plan_proc_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        vmap.put("plan_proc_cd", plan_proc_cd);
        Map<String, Object> resultOne = assetService.productInoutOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }

    @PostMapping("/mes/asset/part/resultModify")
    public ResponseEntity<String> resultModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        assetService.resultModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
