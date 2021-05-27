package edu.bit.ex.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import edu.bit.ex.board.page.Criteria;
import edu.bit.ex.board.page.PageVO;
import edu.bit.ex.board.service.BoardService;
import edu.bit.ex.board.service.MemberService;
import edu.bit.ex.board.vo.BoardComment;
import edu.bit.ex.board.vo.BoardVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RestController
@RequestMapping("/member/*")
public class BoardController {

	@Autowired
	private BoardService bService;

	@Autowired
	private MemberService mService;

	// 게시판 리스트페이지
	@GetMapping("/board/list")
	public ModelAndView list(ModelAndView mav, Criteria cri, Authentication authentication) {
		log.info("getList");
		mav.setViewName("board/list");
		mav.addObject("list", bService.getList(cri));

		int total = bService.getTotal(cri);
		log.info("getTotal");
		mav.addObject("pageMaker", new PageVO(cri, total));

		if (authentication != null) {

			// UsernamePasswordAuthenticationToken에 넣었던 UserDetails 객체 반환
			UserDetails userVO = (UserDetails) authentication.getPrincipal();
			log.info("ID정보 : " + userVO.getUsername());
			log.info("권한정보 : " + userVO.getAuthorities());
			mav.addObject("mbr", userVO.getUsername());
		}

		return mav;
	}

	// 게시판 상세페이지
	@GetMapping("/board/contentView/{bId}")
	public ModelAndView contentView(@PathVariable("bId") int bId, ModelAndView mav, Authentication authentication) {
		log.info("getContentView");
		mav.setViewName("board/contentView");

		// 게시글 정보 불러오기
		mav.addObject("contentView", bService.getContentView(bId));
		// 판매자가 작성한 댓글 불러오기
		mav.addObject("comment", bService.getComment(bId));
		bService.getHit(bId);

		if (authentication != null) {

			// UsernamePasswordAuthenticationToken에 넣었던 UserDetails 객체 반환
			UserDetails userVO = (UserDetails) authentication.getPrincipal();
			log.info("ID정보 : " + userVO.getUsername());
			log.info("권한정보 : " + userVO.getAuthorities());
			mav.addObject("mbr", userVO.getUsername());
		}

		return mav;
	}

	// 게시판 삭제
	@DeleteMapping("/board/modifyView/{bId}")
	public ResponseEntity<String> boardDelete(@PathVariable("bId") int bId, Model model) {
		ResponseEntity<String> entity = null;
		log.info("getDelete");

		try {
			bService.getDelete(bId);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK); // 삭제가 성공하면 상태메시지 저장
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); // 댓글 삭제가 실패하면 BAD_REQUEST를 리턴
		}

		return entity; // 삭제 처리 HTTP 상태 메시지 리턴
	}

	// 게시글 작성페이지
	@GetMapping("/board/writeView")
	public ModelAndView writeView(ModelAndView mav, Authentication authentication) {
		log.info("getWriteView");
		mav.setViewName("board/writeView");

		if (authentication != null) {

			// UsernamePasswordAuthenticationToken에 넣었던 UserDetails 객체 반환
			UserDetails userVO = (UserDetails) authentication.getPrincipal();
			log.info("ID정보 : " + userVO.getUsername());
			log.info("권한정보 : " + userVO.getAuthorities());
			mav.addObject("mbr", userVO.getUsername());
		}

		return mav;
	}

	// 게시글 작성
	@PutMapping("/board/write")
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

	// 게시글 수정페이지
	@GetMapping("/board/modifyView/{bId}")
	public ModelAndView modifyView(ModelAndView mav, @PathVariable("bId") int bId, Authentication authentication) {
		log.info("getModifyView");
		mav.setViewName("board/modifyView");
		mav.addObject("modifyView", bService.getContentView(bId));

		if (authentication != null) {

			// UsernamePasswordAuthenticationToken에 넣었던 UserDetails 객체 반환
			UserDetails userVO = (UserDetails) authentication.getPrincipal();
			log.info("ID정보 : " + userVO.getUsername());
			log.info("권한정보 : " + userVO.getAuthorities());
			mav.addObject("mbr", userVO.getUsername());
		}

		return mav;
	}

	// 게시글 수정
	@PutMapping("/board/modifyView/{bId}/modify")
	public ResponseEntity<String> modify(@RequestBody BoardVO bVO) {
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

	// 게시글 삭제
	@DeleteMapping(value = "/board/modifyView/{bId}/delete")
	public ResponseEntity<String> boardDelete(@PathVariable("bId") int bId) {
		ResponseEntity<String> entity = null;
		log.info("CommentDelete...");

		try {
			bService.getDelete(bId);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 등록
	@PostMapping("/board/contentView/{bId}")
	public ResponseEntity<String> commentRegister(@PathVariable int bId, @RequestBody BoardComment bcVO, ModelAndView mav) {

		ResponseEntity<String> entity = null;
		log.info("commentRegister...");
		try {
			bService.commentInsert(bcVO);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 삭제
	@DeleteMapping(value = "/board/contentView/{bId}/delete/{comment_id}")
	public ResponseEntity<String> CommentDelete(@PathVariable("comment_id") int comment_id) {
		ResponseEntity<String> entity = null;
		log.info("CommentDelete...");

		try {
			bService.commentRemove(comment_id);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 수정
	@PutMapping("/board/contentView/{bId}/modify")
	public ResponseEntity<String> commentUpdate(@RequestBody BoardComment bcVO) {

		ResponseEntity<String> entity = null;
		log.info("commentRegister...");
		try {
			bService.commentUpdate(bcVO);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

}
