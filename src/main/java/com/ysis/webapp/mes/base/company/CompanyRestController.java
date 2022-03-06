package com.ysis.webapp.mes.base.company;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class CompanyRestController {

    @Autowired CompanyService companyService;

    @PostMapping("/mes/base/company/compList")
    public ResponseEntity<List<Map<String, Object>>> compList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> compList = companyService.compList(vmap);

        return new ResponseEntity<>(compList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/company/compOne/{comp_cd}")
    public ResponseEntity<Map<String, Object>> compOne(VMap vmap, @PathVariable("comp_cd") String comp_cd) throws Exception
    {
        vmap.put("comp_cd", comp_cd);
        Map<String, Object> compOne = companyService.compOne(vmap);

        return new ResponseEntity<>(compOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/company/compOverlap/{comp_cd}")
    public ResponseEntity<Boolean> compOverlap(VMap vmap, @PathVariable("comp_cd") String comp_cd) throws Exception
    {
        vmap.put("comp_cd", comp_cd);
        Map<String, Object> compOverlap = companyService.compOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(compOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @GetMapping("/mes/base/company/compCompletOverlap/{selector}")
    public ResponseEntity<List<Map<String, Object>>> compCompletOverlap(VMap vmap, @PathVariable("selector") String selector) throws Exception
    {
        vmap.put("selector", selector);
        List<Map<String, Object>> compOverlapList = companyService.compCompletOverlap(vmap);

        return new ResponseEntity<>(compOverlapList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/company/compRegistModify")
    public ResponseEntity<String> compRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        companyService.compRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/company/compPackDelete")
    public ResponseEntity<String> compPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        companyService.compPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
