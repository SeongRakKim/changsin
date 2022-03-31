package com.ksr.webapp.mes.sales.shipment;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class SalesShipmentRestController {

    @Autowired
    SalesShipmentService salesShipmentService;

    @PostMapping("/mes/sales/shipment/shipList")
    public ResponseEntity<List<Map<String, Object>>> shipList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = salesShipmentService.shipList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @GetMapping("/mes/sales/shipment/shipOne/{odr_cd}/{ship_cd}")
    public ResponseEntity<Map<String, Object>> shipOne(VMap vmap, @PathVariable("odr_cd") String odr_cd, @PathVariable("ship_cd") String ship_cd) throws Exception
    {
        vmap.put("odr_cd", odr_cd);
        vmap.put("ship_cd", ship_cd);
        Map<String, Object> resultOne = salesShipmentService.shipOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }

    @PostMapping("/mes/sales/shipment/salesShipmentDetailtList")
    public ResponseEntity<List<Map<String, Object>>> salesShipmentDetailtList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = salesShipmentService.salesShipmentDetailtList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @PostMapping("/mes/sales/shipment/salesShipmentDetailRegistModify")
    public ResponseEntity<String> planResultRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        salesShipmentService.salesShipmentDetailRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/sales/shipment/salesShipmentDetailDelete")
    public ResponseEntity<String> salesShipmentDetailDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        salesShipmentService.salesShipmentDetailDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }


}
