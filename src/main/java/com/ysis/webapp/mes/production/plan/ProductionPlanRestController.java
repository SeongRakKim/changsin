package com.ysis.webapp.mes.production.plan;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProductionPlanRestController {

    @Autowired
    ProductionPlanService productionPlanService;

    @PostMapping("/mes/production/plan/planList")
    public ResponseEntity<List<Map<String, Object>>> planList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> planList = productionPlanService.planList(vmap);

        return new ResponseEntity<>(planList, HttpStatus.OK);
    }

    @GetMapping("/mes/production/plan/planOne/{odr_cd}")
    public ResponseEntity<Map<String, Object>> planOne(VMap vmap, @PathVariable("odr_cd") String odr_cd) throws Exception
    {
        vmap.put("odr_cd", odr_cd);
        Map<String, Object> planOne = productionPlanService.planOne(vmap);

        return new ResponseEntity<>(planOne, HttpStatus.OK);
    }

    @GetMapping("/mes/production/plan/planOverlap/{plan_cd}")
    public ResponseEntity<Boolean> planOverlap(VMap vmap, @PathVariable("plan_cd") String plan_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        Map<String, Object> planOverlap = productionPlanService.planOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(planOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/production/plan/planRegist")
    public ResponseEntity<String> planRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionPlanService.planRegist(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/plan/planModify")
    public ResponseEntity<String> planModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionPlanService.planModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/production/plan/planPackDelete")
    public ResponseEntity<String> planPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productionPlanService.planPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/plan/process/planProcList")
    public ResponseEntity<List<Map<String, Object>>> planProcList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> planList = productionPlanService.planProcList(vmap);

        return new ResponseEntity<>(planList, HttpStatus.OK);
    }

    @PostMapping("/mes/production/plan/process/planProcRegistModify")
    public ResponseEntity<String> planProcRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionPlanService.planProcRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/production/plan/process/planProcDelete")
    public ResponseEntity<String> planProcDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productionPlanService.planProcDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/plan/bom/planBomList")
    public ResponseEntity<List<Map<String, Object>>> planBomList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> planList = productionPlanService.planBomList(vmap);

        return new ResponseEntity<>(planList, HttpStatus.OK);
    }

    @PostMapping("/mes/production/plan/bom/planBomRegistModify")
    public ResponseEntity<String> planBomRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionPlanService.planBomRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/production/plan/bom/planBomDelete")
    public ResponseEntity<String> planBomDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productionPlanService.planBomDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
