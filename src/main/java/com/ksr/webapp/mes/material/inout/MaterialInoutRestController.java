package com.ksr.webapp.mes.material.inout;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class MaterialInoutRestController {

    @Autowired
    MaterialInoutService materialInoutService;

    @PostMapping("/mes/material/inout/materialInoutList")
    public ResponseEntity<List<Map<String, Object>>> materialInoutList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = materialInoutService.materialInoutList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @GetMapping("/mes/material/inout/materialInoutOne/{plan_cd}/{plan_proc_cd}")
    public ResponseEntity<Map<String, Object>> materialInoutOne(VMap vmap, @PathVariable("plan_cd") String plan_cd, @PathVariable("plan_proc_cd") String plan_proc_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        vmap.put("plan_proc_cd", plan_proc_cd);
        Map<String, Object> resultOne = materialInoutService.materialInoutOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }

    @PostMapping("/mes/material/inout/resultModify")
    public ResponseEntity<String> resultModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        materialInoutService.resultModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
