package com.ksr.webapp.mes.quality;

import com.ksr.webapp.common.vo.VMap;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@Transactional
@RequiredArgsConstructor
public class QualityRestController {

    private final QualityQueryRepository qualityQueryRepository;

    @PostMapping("/mes/quality/material/materialInspectList")
    public ResponseEntity<List<PurchaseQualityData>> materialInspectList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<PurchaseQualityData> purchasesList = qualityQueryRepository.materialInspectList(vmap);

        return new ResponseEntity<>(purchasesList, HttpStatus.OK);
    }

    @PostMapping("/mes/quality/material/materialQualityModify")
    public ResponseEntity<String> materialQualityModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        qualityQueryRepository.materialQualityModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/quality/process/processInspectList")
    public ResponseEntity<List<ProcessQualityData>> processInspectList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<ProcessQualityData> purchasesList = qualityQueryRepository.processInspectList(vmap);

        return new ResponseEntity<>(purchasesList, HttpStatus.OK);
    }

    @GetMapping("/mes/quality/process/processInspectOne/{plan_cd}/{plan_proc_cd}")
    public ResponseEntity<ProcessQualityData> processInspectOne(VMap vmap, @PathVariable("plan_cd") String plan_cd, @PathVariable("plan_proc_cd") String plan_proc_cd) throws Exception
    {
        vmap.put("plan_cd", plan_cd);
        vmap.put("plan_proc_cd", plan_proc_cd);
        ProcessQualityData processInspectOne = qualityQueryRepository.processInspectOne(vmap);

        return new ResponseEntity<>(processInspectOne, HttpStatus.OK);
    }

    @PostMapping("/mes/quality/process/processQualityModify")
    public ResponseEntity<String> processQualityModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        qualityQueryRepository.processQualityModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/quality/shipment/shipmentInspectList")
    public ResponseEntity<List<ShipmentQualityData>> shipmentInspectList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<ShipmentQualityData> purchasesList = qualityQueryRepository.shipmentInspectList(vmap);

        return new ResponseEntity<>(purchasesList, HttpStatus.OK);
    }

    @GetMapping("/mes/quality/shipment/shipmentInspectOne/{odr_cd}/{ship_cd}")
    public ResponseEntity<ShipmentQualityData> shipmentInspectOne(VMap vmap, @PathVariable("odr_cd") String odr_cd, @PathVariable("ship_cd") String ship_cd) throws Exception
    {
        vmap.put("odr_cd", odr_cd);
        vmap.put("ship_cd", ship_cd);
        ShipmentQualityData processInspectOne = qualityQueryRepository.shipmentInspectOne(vmap);

        return new ResponseEntity<>(processInspectOne, HttpStatus.OK);
    }

    @PostMapping("/mes/quality/shipment/shipmentQualityModify")
    public ResponseEntity<String> shipmentQualityModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        qualityQueryRepository.shipmentQualityModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

//    @PostMapping("/mes/base/grade/gradeRegistModify")
//    public ResponseEntity<String> gradeRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
//    {
//        vmap.set(map);
//        gradeQueryRepository.gradeRegistModify(vmap);
//
//        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
//    }
//
//    @DeleteMapping("/mes/base/grade/gradeDelete")
//    public ResponseEntity<String> gradeDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
//    {
//        vmap.set(map);
//        gradeQueryRepository.gradeDelete(vmap);
//
//        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
//    }

}
