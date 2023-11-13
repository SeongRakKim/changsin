package com.ksr.webapp.mes.base.sensor;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class SensorRestController {

    @Autowired
    SensorService sensorService;

    @PostMapping("/mes/base/sensor/snsrList")
    public ResponseEntity<List<Map<String, Object>>> snsrList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> snsrList = sensorService.snsrList(vmap);

        return new ResponseEntity<>(snsrList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/sensor/snsrOne/{snsr_cd}")
    public ResponseEntity<Map<String, Object>> snsrOne(VMap vmap, @PathVariable("snsr_cd") String snsr_cd) throws Exception
    {
        vmap.put("snsr_cd", snsr_cd);
        Map<String, Object> snsrOne = sensorService.snsrOne(vmap);

        return new ResponseEntity<>(snsrOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/sensor/snsrOne2/{snsr_cd}")
    public ResponseEntity<Map<String, Object>> snsrOne2(VMap vmap, @PathVariable("snsr_cd") String snsr_cd) throws Exception
    {
        vmap.put("snsr_cd", snsr_cd);
        Map<String, Object> snsrOne = sensorService.snsrOne2(vmap);

        return new ResponseEntity<>(snsrOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/sensor/snsrOverlap/{snsr_cd}")
    public ResponseEntity<Boolean> snsrOverlap(VMap vmap, @PathVariable("snsr_cd") String snsr_cd) throws Exception
    {
        vmap.put("snsr_cd", snsr_cd);
        Map<String, Object> snsrOverlap = sensorService.snsrOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(snsrOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/sensor/snsrRegistModify")
    public ResponseEntity<String> snsrRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        sensorService.snsrRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/sensor/snsrPackDelete")
    public ResponseEntity<String> snsrPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        sensorService.snsrPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }


}
