package com.ysis.webapp.mes.base.company;

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
        Map<String, Object> compList = companyService.compOne(vmap);

        return new ResponseEntity<>(compList, HttpStatus.OK);
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
