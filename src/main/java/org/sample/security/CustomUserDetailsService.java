package org.sample.security;

import java.util.Arrays;

import org.sample.domain.MemberVO;
import org.sample.mapper.MemberMapper;
import org.sample.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.warn("Load User By UserName : " + username);

        // username은 로그인 시 입력한 ID (이메일 등 고유값)
        MemberVO vo = memberMapper.read(username);

        if (vo == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
        }

        // ✅ CustomUser에 userid를 getUsername()으로 설정
        return new CustomUser(
            String.valueOf(vo.getUserid()), // 여기! → Principal.getName() == userid
            vo.getPwd(),
            Arrays.asList(new SimpleGrantedAuthority("ROLE_USER")),
            vo
        );
    }
}
