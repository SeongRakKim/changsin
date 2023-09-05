package com.ksr.webapp.mes.production.result;

import com.ksr.webapp.common.vo.VMap;
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

    @PostMapping("/mes/production/result/planResultList")
    public ResponseEntity<List<Map<String, Object>>> planResultList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productionResultService.planResultList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planMonStateList")
    public ResponseEntity<List<Map<String, Object>>> planMonStateList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productionResultService.planMonStateList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @GetMapping("/mes/production/result/planResultOne/{plan_res_cd}")
    public ResponseEntity<Map<String, Object>> planResultOne2(VMap vmap, @PathVariable("plan_res_cd") String plan_res_cd) throws Exception
    {
        vmap.put("plan_res_cd", plan_res_cd);
        Map<String, Object> resultOne = productionResultService.planResultOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }
    @GetMapping("/mes/production/result/planResultOne/{plan_cd}/{plan_proc_cd}/{plan_res_cd}")
    public ResponseEntity<Map<String, Object>> planResultOne(VMap vmap, @PathVariable("plan_cd") String plan_cd
            , @PathVariable("plan_proc_cd") String plan_proc_cd , @PathVariable("plan_res_cd") String plan_res_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        vmap.put("plan_proc_cd", plan_proc_cd);
        vmap.put("plan_res_cd", plan_res_cd);
        Map<String, Object> resultOne = productionResultService.planResultOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }


    @PostMapping("/mes/production/result/planResultRegist")
    public ResponseEntity<String> planResultRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionResultService.planResultRegist(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planResultModify")
    public ResponseEntity<String> planResultModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionResultService.planResultModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/production/result/planResultDelete")
    public ResponseEntity<String> planResultDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productionResultService.planResultDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planInputList")
    public ResponseEntity<List<Map<String, Object>>> planInputList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productionResultService.planInputList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planStopList")
    public ResponseEntity<List<Map<String, Object>>> planStopList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productionResultService.planStopList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planStopRegistModify")
    public ResponseEntity<String> planStopRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionResultService.planStopRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }


    @DeleteMapping("/mes/production/result/planStopDelete")
    public ResponseEntity<String> planStopDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productionResultService.planStopDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/production/result/planProcessComplete")
    public ResponseEntity<String> planProcessComplete(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productionResultService.planProcessComplete(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
