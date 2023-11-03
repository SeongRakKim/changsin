package com.ksr.webapp.mes.base.equipment;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class EquipmentRestController {

    @Autowired
    EquipmentService equipmentService;

    @PostMapping("/mes/base/equipment/equList")
    public ResponseEntity<List<Map<String, Object>>> equList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> equList = equipmentService.equList(vmap);

        return new ResponseEntity<>(equList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/equipment/equOne/{equ_cd}")
    public ResponseEntity<Map<String, Object>> equOne(VMap vmap, @PathVariable("equ_cd") String equ_cd) throws Exception
    {
        vmap.put("equ_cd", equ_cd);
        Map<String, Object> equOne = equipmentService.equOne(vmap);

        return new ResponseEntity<>(equOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/equipment/equOverlap/{equ_cd}")
    public ResponseEntity<Boolean> equOverlap(VMap vmap, @PathVariable("equ_cd") String equ_cd) throws Exception
    {
        vmap.put("equ_cd", equ_cd);
        Map<String, Object> equOverlap = equipmentService.equOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(equOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/equipment/equRegistModify")
    public ResponseEntity<String> equRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        equipmentService.equRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/equipment/equPackDelete")
    public ResponseEntity<String> equPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        equipmentService.equPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/base/equipment/equRepairList")
    public ResponseEntity<List<Map<String, Object>>> equRepairList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> equList = equipmentService.equRepairList(vmap);

        return new ResponseEntity<>(equList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/equipment/equRepairOne/{equ_cd}/{equ_repair_cd}")
    public ResponseEntity<Map<String, Object>> equRepairOne(VMap vmap, @PathVariable("equ_cd") String equ_cd, @PathVariable("equ_repair_cd") String equ_repair_cd) throws Exception
    {
        vmap.put("equ_cd", equ_cd);
        vmap.put("equ_repair_cd", equ_repair_cd);
        Map<String, Object> equOne = equipmentService.equRepairOne(vmap);

        return new ResponseEntity<>(equOne, HttpStatus.OK);
    }

    @PostMapping("/mes/base/equipment/equRepairRegistModify")
    public ResponseEntity<String> equRepairRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        equipmentService.equRepairRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/equipment/equRepairPackDelete")
    public ResponseEntity<String> equRepairPackDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        equipmentService.equRepairPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }


}
