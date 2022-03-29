package com.ysis.webapp.mes.sales.shipment;

import com.ysis.webapp.common.vo.VMap;
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

    @PostMapping("/mes/sales/shipment/salesShipmentDetailRegistModify")
    public ResponseEntity<String> planResultRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        salesShipmentService.salesShipmentDetailRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }


//    @PostMapping("/mes/sales/shipment/planResultList")
//    public ResponseEntity<List<Map<String, Object>>> planResultList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        List<Map<String, Object>> resultList = salesShipmentService.planResultList(vmap);
//
//        return new ResponseEntity<>(resultList, HttpStatus.OK);
//    }
//
//    @GetMapping("/mes/sales/shipment/planResultOne/{plan_cd}/{plan_proc_cd}/{plan_res_cd}")
//    public ResponseEntity<Map<String, Object>> planResultOne(VMap vmap, @PathVariable("plan_cd") String plan_cd
//            , @PathVariable("plan_proc_cd") String plan_proc_cd , @PathVariable("plan_res_cd") String plan_res_cd) throws Exception
//    {
//        vmap.put("plan_cd", plan_cd);
//        vmap.put("plan_proc_cd", plan_proc_cd);
//        vmap.put("plan_res_cd", plan_res_cd);
//        Map<String, Object> resultOne = salesShipmentService.planResultOne(vmap);
//
//        return new ResponseEntity<>(resultOne, HttpStatus.OK);
//    }
//
//
//    @PostMapping("/mes/sales/shipment/planResultRegist")
//    public ResponseEntity<String> planResultRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        salesShipmentService.planResultRegist(vmap);
//
//        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//    }
//
//    @PostMapping("/mes/sales/shipment/planResultModify")
//    public ResponseEntity<String> planResultModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        salesShipmentService.planResultModify(vmap);
//
//        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//    }
//
//    @DeleteMapping("/mes/sales/shipment/planResultDelete")
//    public ResponseEntity<String> planResultDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
//    {
//        vmap.set(map);
//        salesShipmentService.planResultDelete(vmap);
//
//        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
//    }
//
//    @PostMapping("/mes/sales/shipment/planInputList")
//    public ResponseEntity<List<Map<String, Object>>> planInputList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        List<Map<String, Object>> resultList = salesShipmentService.planInputList(vmap);
//
//        return new ResponseEntity<>(resultList, HttpStatus.OK);
//    }
//
//    @PostMapping("/mes/sales/shipment/planStopList")
//    public ResponseEntity<List<Map<String, Object>>> planStopList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        List<Map<String, Object>> resultList = salesShipmentService.planStopList(vmap);
//
//        return new ResponseEntity<>(resultList, HttpStatus.OK);
//    }
//
//    @PostMapping("/mes/sales/shipment/planStopRegistModify")
//    public ResponseEntity<String> planStopRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        salesShipmentService.planStopRegistModify(vmap);
//
//        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//    }
//
//
//    @DeleteMapping("/mes/sales/shipment/planStopDelete")
//    public ResponseEntity<String> planStopDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
//    {
//        vmap.set(map);
//        salesShipmentService.planStopDelete(vmap);
//
//        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
//    }
//
//    @PostMapping("/mes/sales/shipment/planProcessComplete")
//    public ResponseEntity<String> planProcessComplete(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        salesShipmentService.planProcessComplete(vmap);
//
//        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//    }

}
