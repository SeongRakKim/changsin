package com.ksr.webapp.mes.base.tool;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class ToolRestController {

    @Autowired
    ToolService toolService;

    @PostMapping("/mes/base/tool/toolList")
    public ResponseEntity<List<Map<String, Object>>> toolList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> toolList = toolService.toolList(vmap);

        return new ResponseEntity<>(toolList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/tool/toolOne/{tool_cd}")
    public ResponseEntity<Map<String, Object>> toolOne(VMap vmap, @PathVariable("tool_cd") String tool_cd) throws Exception
    {
        vmap.put("tool_cd", tool_cd);
        Map<String, Object> toolOne = toolService.toolOne(vmap);

        return new ResponseEntity<>(toolOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/tool/toolOverlap/{tool_cd}")
    public ResponseEntity<Boolean> toolOverlap(VMap vmap, @PathVariable("tool_cd") String tool_cd) throws Exception
    {
        vmap.put("tool_cd", tool_cd);
        Map<String, Object> toolOverlap = toolService.toolOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(toolOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/tool/toolRegistModify")
    public ResponseEntity<String> toolRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        toolService.toolRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/tool/toolPackDelete")
    public ResponseEntity<String> toolPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        toolService.toolPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }


}
