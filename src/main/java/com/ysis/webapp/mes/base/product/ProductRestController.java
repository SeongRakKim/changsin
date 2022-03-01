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

    @PostMapping("/mes/base/product/compList")
    public ResponseEntity<List<Map<String, Object>>> compList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> compList = productService.compList(vmap);

        return new ResponseEntity<>(compList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/product/compOne/{comp_cd}")
    public ResponseEntity<Map<String, Object>> compOne(VMap vmap, @PathVariable("comp_cd") String comp_cd) throws Exception
    {
        vmap.put("comp_cd", comp_cd);
        Map<String, Object> compOne = productService.compOne(vmap);

        return new ResponseEntity<>(compOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/product/compOverlap/{comp_cd}")
    public ResponseEntity<Boolean> compOverlap(VMap vmap, @PathVariable("comp_cd") String comp_cd) throws Exception
    {
        vmap.put("comp_cd", comp_cd);
        Map<String, Object> compOverlap = productService.compOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(compOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/product/compRegistModify")
    public ResponseEntity<String> compRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        productService.compRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/product/compPackDelete")
    public ResponseEntity<String> compPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        productService.compPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
