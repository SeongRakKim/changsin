package com.ksr.webapp.mes.base.process;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ProcessRestController {

    @Autowired
    ProcessService processService;

    @PostMapping("/mes/base/process/procList")
    public ResponseEntity<List<Map<String, Object>>> procList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> procList = processService.procList(vmap);

        return new ResponseEntity<>(procList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/process/procOne/{proc_cd}")
    public ResponseEntity<Map<String, Object>> procOne(VMap vmap, @PathVariable("proc_cd") String proc_cd) throws Exception
    {
        vmap.put("proc_cd", proc_cd);
        Map<String, Object> procOne = processService.procOne(vmap);

        return new ResponseEntity<>(procOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/process/procOverlap/{proc_cd}")
    public ResponseEntity<Boolean> procOverlap(VMap vmap, @PathVariable("proc_cd") String proc_cd) throws Exception
    {
        vmap.put("proc_cd", proc_cd);
        Map<String, Object> procOverlap = processService.procOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(procOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/process/procRegistModify")
    public ResponseEntity<String> procRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        processService.procRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/process/procPackDelete")
    public ResponseEntity<String> procPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        processService.procPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
