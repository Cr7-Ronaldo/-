package org.sample.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.sample.domain.Criteria;
import org.sample.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	public ReplyVO read(Long rno);
	public int delete(Long rno);
	public int update(ReplyVO vo);
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("boardid") Long boardid
			);
	public int getCountByBoardid(Long boardid);
}
