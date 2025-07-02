package org.sample.domain;


import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	 private Long userid;
	 private String nickname;  // 로그인 ID
	 private String pwd;       // 비밀번호
	 private String email;

	
	
	
}
