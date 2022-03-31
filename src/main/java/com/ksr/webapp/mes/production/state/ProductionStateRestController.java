package com.ksr.webapp.mes.production.state;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProductionStateRestController {

    @Autowired
    ProductionStateService productionStateService;

    @PostMapping("/mes/production/state/stateList")
    public ResponseEntity<List<Map<String, Object>>> stateList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> planList = productionStateService.stateList(vmap);

        return new ResponseEntity<>(planList, HttpStatus.OK);
    }

    @GetMapping("/mes/production/state/stateOne/{plan_cd}")
    public ResponseEntity<Map<String, Object>> stateOne(VMap vmap, @PathVariable("plan_cd") String plan_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        Map<String, Object> resultOne = productionStateService.stateOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }


}
