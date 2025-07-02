package org.sample.security.domain;

import java.util.Collection;

import org.sample.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {

    private static final long serialVersionUID = 1L;

    private MemberVO member;

    public CustomUser(String username, String password,
                      Collection<? extends GrantedAuthority> authorities,
                      MemberVO member) {
        super(username, password, authorities);
        this.member = member;
    }

    public MemberVO getMember() {
        return member;
    }

    // 이미 username이 userid로 설정돼 있으므로 getUsername() 오버라이드는 필요 없음
}
