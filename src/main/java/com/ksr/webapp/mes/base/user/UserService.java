package com.ksr.webapp.mes.base.user;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class UserService {

    private CommonDAO commonDAO;

    @Autowired
    private UserDAO userDAO;

    @Lazy
    @Autowired
    private PasswordEncoder passwordEncoder;


    public List<Map<String, Object>> userList(VMap vmap) throws Exception {
        return userDAO.userList(vmap);
    }

    public Map<String, Object> userOne(VMap vmap) throws Exception {
        return userDAO.userOne(vmap);
    }

    public Map<String, Object> userOne(String u_cd) throws Exception {
        return userDAO.userOne(u_cd);
    }

    public Map<String, Object> userOverlap(VMap vmap) throws Exception {
        return userDAO.userOverlap(vmap);
    }

    @Transactional
    public int userRegistModify(VMap vmap) throws Exception {

        vmap.put("u_pw", passwordEncoder.encode(vmap.getString("u_pw")));
        return userDAO.userRegistModify(vmap);
    }

    @Transactional
    public int apiLogRegist(VMap vmap) throws Exception {
        return userDAO.apiLogRegist(vmap);
    }

    public int userPackDelete(VMap vmap) throws Exception {
        return userDAO.userPackDelete(vmap);
    }

}
