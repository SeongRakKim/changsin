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

    // 제품
    @GetMapping("/mes/base/product/prodOverlap2/{selector}")
    public ResponseEntity<List<Map<String, Object>>> prodOverlap2(VMap vmap, @PathVariable("selector") String selector) throws Exception
    {
        vmap.put("selector", selector);
        List<Map<String, Object>> prodOverlapList = productService.prodOverlap2(vmap);

        return new ResponseEntity<>(prodOverlapList, HttpStatus.OK);
    }

    // 반제품, 자재
    @GetMapping("/mes/base/product/prodOverlap3/{selector}")
    public ResponseEntity<List<Map<String, Object>>> prodOverlap3(VMap vmap, @PathVariable("selector") String selector) throws Exception
    {
        vmap.put("selector", selector);
        List<Map<String, Object>> prodOverlapList = productService.prodOverlap3(vmap);

        return new ResponseEntity<>(prodOverlapList, HttpStatus.OK);
    }

    // 제품, 반제품
    @GetMapping("/mes/base/product/prodOverlap4/{selector}")
    public ResponseEntity<List<Map<String, Object>>> prodOverlap4(VMap vmap, @PathVariable("selector") String selector) throws Exception
    {
        vmap.put("selector", selector);
        List<Map<String, Object>> prodOverlapList = productService.prodOverlap4(vmap);

        return new ResponseEntity<>(prodOverlapList, HttpStatus.OK);
    }

    // 자재
    @GetMapping("/mes/base/product/prodOverlap5/{selector}")
    public ResponseEntity<List<Map<String, Object>>> prodOverlap5(VMap vmap, @PathVariable("selector") String selector) throws Exception
    {
        vmap.put("selector", selector);
        List<Map<String, Object>> prodOverlapList = productService.prodOverlap5(vmap);

        return new ResponseEntity<>(prodOverlapList, HttpStatus.OK);
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

    @PostMapping("/mes/base/product/process/prodProcList")
    public ResponseEntity<List<Map<String, Object>>> prodProcList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> prodList = productService.prodProcList(vmap);

        return new ResponseEntity<>(prodList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/product/process/prodProcRegistModify")
    public ResponseEntity<String> prodProcRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productService.prodProcRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/product/process/prodProcDelete")
    public ResponseEntity<String> prodProcDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productService.prodProcDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/base/product/bom/prodBomList")
    public ResponseEntity<List<Map<String, Object>>> prodBomList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> prodList = productService.prodBomList(vmap);

        return new ResponseEntity<>(prodList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/product/bom/prodBomRegistModify")
    public ResponseEntity<String> prodBomRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productService.prodBomRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/product/bom/prodBomDelete")
    public ResponseEntity<String> prodBomDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productService.prodBomDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
