package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@Transactional
@RequiredArgsConstructor
public class DepartmentRestController {

    private final DepartmentQueryRepository departmentQueryRepository;
    private final GradeQueryRepository gradeQueryRepository;

    @PostMapping("/mes/base/department/deptList")
    public ResponseEntity<List<Department>> deptList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Department> deptList = departmentQueryRepository.deptList(vmap);

        return new ResponseEntity<>(deptList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/department/deptRegistModify")
    public ResponseEntity<String> deptRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        departmentQueryRepository.deptRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/department/deptDelete")
    public ResponseEntity<String> deptDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        departmentQueryRepository.deptDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

    @PostMapping("/mes/base/department/gradeList")
    public ResponseEntity<List<Grade>> gradeList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Grade> gradeList = gradeQueryRepository.gradeList(vmap);

        return new ResponseEntity<>(gradeList, HttpStatus.OK);
    }

    @PostMapping("/mes/base/department/gradeRegistModify")
    public ResponseEntity<String> gradeRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        gradeQueryRepository.gradeRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/department/gradeDelete")
    public ResponseEntity<String> gradeDelete(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        gradeQueryRepository.gradeDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
