package com.ysis.webapp.mes.production.result;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProductionResultRestController {

    @Autowired
    ProductionResultService productionResultService;

    @PostMapping("/mes/production/result/planProcessList")
    public ResponseEntity<List<Map<String, Object>>> planProcessList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productionResultService.planProcessList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @GetMapping("/mes/production/result/planProcessOne/{plan_cd}/{plan_proc_cd}")
    public ResponseEntity<Map<String, Object>> planProcessOne(VMap vmap, @PathVariable("plan_cd") String plan_cd, @PathVariable("plan_proc_cd") String plan_proc_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        vmap.put("plan_proc_cd", plan_proc_cd);
        Map<String, Object> resultOne = productionResultService.planProcessOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planResultRegist")
    public ResponseEntity<String> planResultRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionResultService.planResultRegist(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/resultModify")
    public ResponseEntity<String> resultModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionResultService.resultModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
