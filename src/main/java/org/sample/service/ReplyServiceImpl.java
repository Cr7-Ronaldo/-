package org.sample.service;

import java.util.List;

import org.sample.domain.Criteria;
import org.sample.domain.ReplyPageDTO;
import org.sample.domain.ReplyVO;
import org.sample.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {

    private final ReplyMapper mapper;

    @Override
    @Transactional
    public int register(ReplyVO vo) {
        return mapper.insert(vo);
    }

    @Override
    public ReplyVO get(Long rno) {
        return mapper.read(rno);
    }

    @Override
    @Transactional
    public int modify(ReplyVO vo) {
        return mapper.update(vo);
    }

    @Override
    @Transactional
    public int remove(Long rno) {
        return mapper.delete(rno);
    }

    // bno → boardid 변경
    @Override
    public List<ReplyVO> getList(Criteria cri, Long boardid) {
        return mapper.getListWithPaging(cri, boardid);
    }

    @Override
    public ReplyPageDTO getListPage(Criteria cri, Long boardid) {
        return new ReplyPageDTO(
            mapper.getCountByBoardid(boardid),
            mapper.getListWithPaging(cri, boardid)
        );
    }
}
