package com.ksr.webapp.mes.base.material;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class MaterialRestController {

    @Autowired
    MaterialService materialService;

    @PostMapping("/mes/base/material/mateList")
    public ResponseEntity<List<Map<String, Object>>> mateList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> mateList = materialService.mateList(vmap);

        return new ResponseEntity<>(mateList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/material/mateOne/{mate_cd}")
    public ResponseEntity<Map<String, Object>> mateOne(VMap vmap, @PathVariable("mate_cd") String mate_cd) throws Exception
    {
        vmap.put("mate_cd", mate_cd);
        Map<String, Object> mateOne = materialService.mateOne(vmap);

        return new ResponseEntity<>(mateOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/material/mateOverlap/{mate_cd}")
    public ResponseEntity<Boolean> mateOverlap(VMap vmap, @PathVariable("mate_cd") String mate_cd) throws Exception
    {
        vmap.put("mate_cd", mate_cd);
        Map<String, Object> mateOverlap = materialService.mateOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(mateOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }


    @GetMapping("/mes/base/material/mateOverlap2/{selector}")
    public ResponseEntity<List<Map<String, Object>>> mateOverlap2(VMap vmap, @PathVariable("selector") String selector) throws Exception
    {
        vmap.put("selector", selector);
        List<Map<String, Object>> mateOverlapList = materialService.mateOverlap2(vmap);

        return new ResponseEntity<>(mateOverlapList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/material/mateRegistModify")
    public ResponseEntity<String> mateRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        materialService.mateRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/material/matePackDelete")
    public ResponseEntity<String> matePackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        materialService.matePackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
