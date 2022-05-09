package com.ksr.webapp.mes.base.user;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

@Data
public class CustomUserDetails implements UserDetails {

    private String userCd;
    private String userPw;
    private String userName;
    private String userAuth;
    private String appendDate;
    private String updateDate;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority(this.userAuth));
    }

    @Override
    public String getPassword() {
        return this.userPw;
    }

    // 시큐리티의 userName
    // -> 따라서 얘는 인증할 때 id를 봄
    @Override
    public String getUsername() {
        return this.userCd;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
