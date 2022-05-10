package com.ksr.webapp.mes.base.user;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class UserRestController {

    @Autowired
    UserService userService;

    @PostMapping("/mes/base/user/userList")
    public ResponseEntity<List<Map<String, Object>>> userList(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        List<Map<String, Object>> userList = userService.userList(vmap);

        return new ResponseEntity<>(userList, HttpStatus.OK);
    }

    @GetMapping("/mes/base/user/userOne/{u_cd}")
    public ResponseEntity<Map<String, Object>> userOne(VMap vmap, @PathVariable("u_cd") String u_cd) throws Exception
    {
        vmap.put("u_cd", u_cd);
        Map<String, Object> userOne = userService.userOne(vmap);

        return new ResponseEntity<>(userOne, HttpStatus.OK);
    }

    @GetMapping("/mes/base/user/userOverlap/{u_cd}")
    public ResponseEntity<Boolean> userOverlap(VMap vmap, @PathVariable("u_cd") String u_cd) throws Exception
    {
        vmap.put("u_cd", u_cd);
        Map<String, Object> userOverlap = userService.userOverlap(vmap);
        boolean isFalg = CommonUtils.isNotEmpty(userOverlap);

        return new ResponseEntity<>(isFalg, HttpStatus.OK);
    }

    @PostMapping("/mes/base/user/userRegistModify")
    public ResponseEntity<String> userRegistModify(VMap vmap, @RequestBody Map<String, Object> map) throws Exception
    {
        vmap.set(map);
        userService.userRegistModify(vmap);

        return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
    }

    @DeleteMapping("/mes/base/user/userPackDelete")
    public ResponseEntity<String> userPackDeleteDELETE(VMap vmap, @RequestBody Map<String, Object> map ) throws Exception
    {
        vmap.set(map);
        userService.userPackDelete(vmap);

        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }

}
