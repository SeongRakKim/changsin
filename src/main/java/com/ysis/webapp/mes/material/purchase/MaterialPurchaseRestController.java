package com.ysis.webapp.mes.material.purchase;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class MaterialPurchaseRestController {

    @Autowired
    MaterialPurchaseService materialPurchaseService;

    @PostMapping("/mes/material/purchase/purchaseList")
    public ResponseEntity<List<Map<String, Object>>> purchaseList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> purchaseList = materialPurchaseService.purchaseList(vmap);

        return new ResponseEntity<>(purchaseList, HttpStatus.OK);
    }

    @PostMapping("/mes/material/purchase/purchaseList2")
    public ResponseEntity<List<Map<String, Object>>> purchaseList2(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> purchaseList = materialPurchaseService.purchaseList2(vmap);

        return new ResponseEntity<>(purchaseList, HttpStatus.OK);
    }

    @GetMapping("/mes/material/purchase/purchaseOne/{pur_cd}")
    public ResponseEntity<Map<String, Object>> purchaseOne(VMap vmap, @PathVariable("pur_cd") String pur_cd) throws Exception
    {
        vmap.put("pur_cd", pur_cd);
        Map<String, Object> purchaseOne = materialPurchaseService.purchaseOne(vmap);

        return new ResponseEntity<>(purchaseOne, HttpStatus.OK);
    }

    @GetMapping("/mes/material/purchase/purchaseOverlap/{purchase_cd}")
    public ResponseEntity<Boolean> purchaseOverlap(VMap vmap, @PathVariable("purchase_cd") String purchase_cd) throws Exception
    {
        vmap.put("purchase_cd", purchase_cd);
        Map<String, Object> purchaseOverlap = materialPurchaseService.purchaseOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(purchaseOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/material/purchase/purchaseRegist")
    public ResponseEntity<String> purchaseRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        materialPurchaseService.purchaseRegist(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/material/purchase/purchaseModify")
    public ResponseEntity<String> purchaseModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        materialPurchaseService.purchaseModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/material/purchase/purchaseInModify")
    public ResponseEntity<String> purchaseInModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        materialPurchaseService.purchaseInModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/material/purchase/purchaseInBundleModify")
    public ResponseEntity<String> purchaseInBundleModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        materialPurchaseService.purchaseInBundleModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/material/purchase/purchasePackDelete")
    public ResponseEntity<String> purchasePackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        materialPurchaseService.purchasePackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
