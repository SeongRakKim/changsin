package com.ysis.webapp.mes.production.state;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
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


}
