package org.sample.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.sample.domain.MemberVO;
import org.sample.security.domain.CustomUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {

		log.warn("Login Success");

		// 🔥 로그인한 사용자 정보 꺼내기
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		MemberVO vo = customUser.getMember();

		// ✅ 세션에 MemberVO를 "loginUser"로 저장
		request.getSession().setAttribute("loginUser", vo);

		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> roleNames.add(authority.getAuthority()));
		log.warn("ROLE NAMES:" + roleNames);

		// ✅ 권한별 리다이렉트
		if (roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/sample/admin");
			return;
		} else if (roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/sample/member");
			return;
		}

		response.sendRedirect("/");
	}
}
