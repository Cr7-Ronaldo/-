package org.sample.controller;

import org.sample.domain.Criteria;
import org.sample.domain.ReplyPageDTO;
import org.sample.domain.ReplyVO;
import org.sample.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Log4j
@RequestMapping("/replies")
public class ReplyController {

    private final ReplyService service;

    // 댓글 등록
    @PostMapping(value = "/new")
    public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
        log.info("댓글 등록 요청: " + vo);

        try {
            int insertCount = service.register(vo);
            return insertCount == 1 ?
                    new ResponseEntity<>("success", HttpStatus.CREATED) :
                    new ResponseEntity<>("댓글 등록 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            log.error("댓글 등록 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<>("댓글 등록 오류", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 댓글 목록 조회 (페이징)
    @GetMapping(value = "/pages/{boardid}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ReplyPageDTO> getList(@PathVariable("boardid") Long boardid,
                                               @PathVariable("page") int page) {
        log.info("댓글 목록 요청: boardid = " + boardid + ", page = " + page);

        try {
            Criteria cri = new Criteria(page, 10);
            ReplyPageDTO dto = service.getListPage(cri, boardid);
            return new ResponseEntity<>(dto, HttpStatus.OK);
        } catch (Exception e) {
            log.error("댓글 목록 조회 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 댓글 단건 조회
    @GetMapping(value = "/{rno}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
        log.info("댓글 단건 조회: rno = " + rno);

        try {
            ReplyVO reply = service.get(rno);
            return reply != null ? new ResponseEntity<>(reply, HttpStatus.OK) :
                    new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            log.error("댓글 조회 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 댓글 삭제
    @DeleteMapping(value = "/{rno}", produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
        log.info("댓글 삭제 요청: rno = " + rno);

        try {
            return service.remove(rno) == 1 ?
                    new ResponseEntity<>("success", HttpStatus.OK) :
                    new ResponseEntity<>("댓글 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            log.error("댓글 삭제 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<>("댓글 삭제 오류", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 댓글 수정
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{rno}",
                    consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
        vo.setRno(rno);
        log.info("댓글 수정 요청: " + vo);

        try {
            return service.modify(vo) == 1 ?
                    new ResponseEntity<>("success", HttpStatus.OK) :
                    new ResponseEntity<>("댓글 수정 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            log.error("댓글 수정 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<>("댓글 수정 오류", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
