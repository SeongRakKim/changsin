package com.ksr.webapp.mes.product.inout;

import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProductInoutRestController {

    @Autowired
    ProductInoutService productInoutService;

    @PostMapping("/mes/product/inout/productInoutList")
    public ResponseEntity<List<Map<String, Object>>> productInoutList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> resultList = productInoutService.productInoutList(vmap);

        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @GetMapping("/mes/product/inout/productInoutOne/{plan_cd}/{plan_proc_cd}")
    public ResponseEntity<Map<String, Object>> productInoutOne(VMap vmap, @PathVariable("plan_cd") String plan_cd, @PathVariable("plan_proc_cd") String plan_proc_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        vmap.put("plan_proc_cd", plan_proc_cd);
        Map<String, Object> resultOne = productInoutService.productInoutOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }

    @PostMapping("/mes/product/inout/resultModify")
    public ResponseEntity<String> resultModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productInoutService.resultModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
