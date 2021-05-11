package edu.bit.ex.board.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import edu.bit.ex.board.page.Criteria;
import edu.bit.ex.board.page.PageVO;
import edu.bit.ex.board.service.BoardService;
import edu.bit.ex.board.vo.BoardVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RestController
@RequestMapping("/board/*")
public class BoardController {
	private BoardService bService;

	// 게시판 리스트페이지
	@GetMapping("/list")
	public ModelAndView list(ModelAndView mav, Criteria cri) {
		log.info("getList");
		mav.setViewName("board/list");
		mav.addObject("list", bService.getList(cri));

		int total = bService.getTotal(cri);
		log.info("getTotal");
		mav.addObject("pageMaker", new PageVO(cri, total));

		return mav;
	}

	// 게시판 상세페이지
	@GetMapping("/contentView/{bId}")
	public ModelAndView contentView(ModelAndView mav, BoardVO bVO) {
		log.info("getContentView");
		mav.setViewName("board/contentView");
		mav.addObject("contentView", bService.getContentView(bVO.getbId()));
		bService.getHit(bVO.getbId());
		return mav;
	}

	// 게시판 삭제
	@DeleteMapping("/contentView/{bId}")
	public ResponseEntity<String> boardDelete(BoardVO bVO, Model model) {
		ResponseEntity<String> entity = null;
		log.info("getDelete");

		try {
			bService.getDelete(bVO.getbId());
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK); // 삭제가 성공하면 상태메시지 저장
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); // 댓글 삭제가 실패하면 BAD_REQUEST를 리턴
		}
		return entity; // 삭제 처리 HTTP 상태 메시지 리턴
	}

	// 게시글 작성페이지
	@GetMapping("/writeView")
	public ModelAndView writeView(ModelAndView mav, BoardVO bVO) {
		log.info("getWriteView");
		mav.setViewName("board/writeView");

		return mav;
	}

	// 게시글 작성
	@PutMapping("/write")
	public ResponseEntity<String> write(@RequestBody BoardVO bVO, Model model) {
		ResponseEntity<String> entity = null;
		log.info("getWrite");

		try {
			bService.getWrite(bVO);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK); // 삭제가 성공하면 상태메시지 저장
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); // 댓글 삭제가 실패하면 BAD_REQUEST를 리턴
		}
		return entity; // 삭제 처리 HTTP 상태 메시지 리턴
	}

	// 게시글 수정
	@PutMapping("/modify")
	public ResponseEntity<String> modify(@RequestBody BoardVO bVO, Model model) {
		ResponseEntity<String> entity = null;
		log.info("getWrite");

		try {
			bService.getModify(bVO);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK); // 삭제가 성공하면 상태메시지 저장
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); // 댓글 삭제가 실패하면 BAD_REQUEST를 리턴
		}
		return entity; // 삭제 처리 HTTP 상태 메시지 리턴
	}

	// 게시글 답변페이지
	@GetMapping("/replyView/{bId}")
	public ModelAndView replyView(ModelAndView mav, BoardVO bVO) {
		log.info("getReplyView");
		mav.setViewName("board/replyView");
		mav.addObject("replyView", bService.getContentView(bVO.getbId()));
		return mav;
	}

	// 게시글 답변작성
	@PutMapping("/replyView/register")
	public ResponseEntity<String> reply(@RequestBody BoardVO bVO, Model model) {
		ResponseEntity<String> entity = null;
		log.info("getreply");

		try {
			bService.getReply(bVO);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK); // 삭제가 성공하면 상태메시지 저장
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); // 댓글 삭제가 실패하면 BAD_REQUEST를 리턴
		}
		return entity; // 삭제 처리 HTTP 상태 메시지 리턴
	}

}
