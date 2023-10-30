package com.ksr.webapp.mes.base.basecode;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class BaseCodeRestController {

    @Autowired
    CommonService commonService;

    @PostMapping("/mes/base/code/baseList")
    public ResponseEntity<List<Map<String, Object>>> mateList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> mateList = commonService.baseList(vmap);

        return new ResponseEntity<>(mateList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/code/baseOne/{base_cd}")
    public ResponseEntity<Map<String, Object>> baseOne(VMap vmap, @PathVariable("base_cd") String base_cd) throws Exception
    {
        vmap.put("base_cd", base_cd);
        Map<String, Object> resultOne = commonService.baseOne(vmap);

        return new ResponseEntity<>(resultOne, HttpStatus.OK);
    }

    @PostMapping("/mes/base/code/baseDetailList")
    public ResponseEntity<List<Map<String, Object>>> baseDetailList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> mateList = commonService.baseDetailList(vmap);

        return new ResponseEntity<>(mateList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/code/baseCodeDetailRegistModify")
    public ResponseEntity<String> planResultRegist(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        commonService.baseCodeDetailRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/code/baseCodeDetailDelete")
    public ResponseEntity<String> baseCodeDetailDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        commonService.baseCodeDetailDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
