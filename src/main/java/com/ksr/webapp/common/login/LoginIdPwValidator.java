package com.ksr.webapp.common.login;

import com.ksr.webapp.mes.base.user.UserDAO;
import com.ksr.webapp.mes.base.user.UserService;
import com.ksr.webapp.mes.base.user.CustomUserDetails;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Service
public class LoginIdPwValidator implements UserDetailsService {

    @Autowired
    UserService userService;

    SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:sss");
    Date time = new Date();
    String localTime = format.format(time);

    private UserDAO userDAO;

    @Override
    public UserDetails loadUserByUsername(String insertedId) throws UsernameNotFoundException {

        CustomUserDetails customUserDetails = null;
        Map<String, Object> customUserDetails2 = null;

        try {
            customUserDetails2 = userService.userOne(insertedId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(customUserDetails2 == null) {
            throw new UsernameNotFoundException("User not authorized");
        }

        return User.builder()
                .username(String.valueOf(customUserDetails2.get("u_cd")))
                .password(String.valueOf(customUserDetails2.get("u_pw")))
                .roles()
                .build();

    }


}
