package com.ysis.webapp.mes.base.company;

import com.ysis.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class CompanyRestController {

    @Autowired CompanyService companyService;

    @PostMapping("/mes/base/company/compRegistModify")
    public ResponseEntity<String> getUserList(VMap vmap, @RequestBody Map<String, Object> map)
    {
        vmap.set(map);


        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

}
