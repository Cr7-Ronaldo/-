package org.sample.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO {

	private Long rno;
	private Long boardid;
	
	private String reply;
	private String replyer;
	
	private Date replyDate;
	private Date updateDate;
}
