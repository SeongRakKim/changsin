package com.ysis.webapp.mes.base.product;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProductRestController {

    @Autowired
    ProductService productService;

    @PostMapping("/mes/base/product/prodList")
    public ResponseEntity<List<Map<String, Object>>> prodList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> prodList = productService.prodList(vmap);

        return new ResponseEntity<>(prodList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/product/prodOne/{prod_cd}")
    public ResponseEntity<Map<String, Object>> prodOne(VMap vmap, @PathVariable("prod_cd") String prod_cd) throws Exception
    {
        vmap.put("prod_cd", prod_cd);
        Map<String, Object> prodOne = productService.prodOne(vmap);

        return new ResponseEntity<>(prodOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/product/prodOverlap/{prod_cd}")
    public ResponseEntity<Boolean> prodOverlap(VMap vmap, @PathVariable("prod_cd") String prod_cd) throws Exception
    {
        vmap.put("prod_cd", prod_cd);
        Map<String, Object> prodOverlap = productService.prodOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(prodOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/product/prodRegistModify")
    public ResponseEntity<String> prodRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productService.prodRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/product/prodPackDelete")
    public ResponseEntity<String> prodPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productService.prodPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
