package org.sample.controller;

import java.security.Principal;
import java.util.Map;

import org.sample.domain.MemberVO;
import org.sample.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@Autowired
    private MemberMapper memberMapper; 
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication authentication, Model model) {
		log.info("access Denied : " + authentication);
		model.addAttribute("msg", "접근이 거부되었습니다.");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "97224a311e2c3d35063e47e14969d29f.gif");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!!");
		}
	
	}
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
	
	@PostMapping("/checkPwd")
	@ResponseBody
	public String checkPassword(@RequestBody Map<String, String> payload, Principal principal) {
	    String inputPwd = payload.get("pwd");
	    String nickname = principal.getName();

	    MemberVO user = memberMapper.read(nickname);
	    
	    // bcrypt 사용 시에는 아래 주석 해제
	    // if (passwordEncoder.matches(inputPwd, user.getPwd())) {
	    if (user != null && passwordEncoder.matches(inputPwd, user.getPwd())) {
	        return "success";
	    } else {
	        return "fail";
	    }
	}
	
}
