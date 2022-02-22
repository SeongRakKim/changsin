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

    @PostMapping("/mes/base/company/compRegistModify")
    public ResponseEntity<String> compRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        companyService.compRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
