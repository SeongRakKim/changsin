package com.ysis.webapp.mes.sales.order;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class SalesOrderRestController {

    @Autowired
    SalesOrderService salesOrderService;

    @PostMapping("/mes/sales/order/orderList")
    public ResponseEntity<List<Map<String, Object>>> orderList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> orderList = salesOrderService.orderList(vmap);

        return new ResponseEntity<>(orderList, HttpStatus.OK);
    }

    @GetMapping("/mes/sales/order/orderOne/{order_cd}")
    public ResponseEntity<Map<String, Object>> orderOne(VMap vmap, @PathVariable("order_cd") String order_cd) throws Exception
    {
        vmap.put("order_cd", order_cd);
        Map<String, Object> orderOne = salesOrderService.orderOne(vmap);

        return new ResponseEntity<>(orderOne, HttpStatus.OK);
    }

    @GetMapping("/mes/sales/order/orderOverlap/{order_cd}")
    public ResponseEntity<Boolean> orderOverlap(VMap vmap, @PathVariable("order_cd") String order_cd) throws Exception
    {
        vmap.put("order_cd", order_cd);
        Map<String, Object> orderOverlap = salesOrderService.orderOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(orderOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/sales/order/orderRegist")
    public ResponseEntity<String> orderRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        salesOrderService.orderRegist(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/sales/order/orderPackDelete")
    public ResponseEntity<String> orderPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        salesOrderService.orderPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/sales/order/process/orderProcList")
    public ResponseEntity<List<Map<String, Object>>> orderProcList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> orderList = salesOrderService.orderProcList(vmap);

        return new ResponseEntity<>(orderList, HttpStatus.OK);
    }

    @PostMapping("/mes/sales/order/process/orderProcRegistModify")
    public ResponseEntity<String> orderProcRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        salesOrderService.orderProcRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/sales/order/process/orderProcDelete")
    public ResponseEntity<String> orderProcDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        salesOrderService.orderProcDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/sales/order/bom/orderBomList")
    public ResponseEntity<List<Map<String, Object>>> orderBomList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> orderList = salesOrderService.orderBomList(vmap);

        return new ResponseEntity<>(orderList, HttpStatus.OK);
    }

    @PostMapping("/mes/sales/order/bom/orderBomRegistModify")
    public ResponseEntity<String> orderBomRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        salesOrderService.orderBomRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/sales/order/bom/orderBomDelete")
    public ResponseEntity<String> orderBomDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        salesOrderService.orderBomDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
