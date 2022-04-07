package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class DepartmentRestController {

    @Autowired
    DepartmentService departmentService;

    @PostMapping("/mes/base/department/deptList")
    public ResponseEntity<List<Map<String, Object>>> deptList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> deptList = departmentService.deptList(vmap);

        return new ResponseEntity<>(deptList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/department/deptOne/{dept_cd}")
    public ResponseEntity<Map<String, Object>> deptOne(VMap vmap, @PathVariable("dept_cd") String dept_cd) throws Exception
    {
        vmap.put("dept_cd", dept_cd);
        Map<String, Object> deptOne = departmentService.deptOne(vmap);

        return new ResponseEntity<>(deptOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/department/deptOverlap/{dept_cd}")
    public ResponseEntity<Boolean> deptOverlap(VMap vmap, @PathVariable("dept_cd") String dept_cd) throws Exception
    {
        vmap.put("dept_cd", dept_cd);
        Map<String, Object> deptOverlap = departmentService.deptOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(deptOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/department/deptRegistModify")
    public ResponseEntity<String> deptRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        departmentService.deptRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/department/deptPackDelete")
    public ResponseEntity<String> deptPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        departmentService.deptPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
