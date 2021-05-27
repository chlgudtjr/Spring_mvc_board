package edu.bit.ex.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import edu.bit.ex.board.service.MemberService;
import edu.bit.ex.board.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RestController
public class MemberController {

	@Autowired
	private MemberService mService;

	// accessDenied 에러페이지
	@GetMapping("/accessDenied")
	public ModelAndView accessDenied(ModelAndView mav) {
		log.info("getAccessDenied");
		mav.setViewName("login/accessDenied");

		return mav;
	}

	// 메인홈페이지
	@GetMapping("/main")
	public ModelAndView main(Authentication authentication, ModelAndView mav) {
		log.info("getMain");
		mav.setViewName("login/main");

		if (authentication != null) {
			log.info("타입정보 : " + authentication.getClass());

			// 세션 정보 객체 반환
			WebAuthenticationDetails web = (WebAuthenticationDetails) authentication.getDetails();
			log.info("세션ID : " + web.getSessionId());
			log.info("접속IP : " + web.getRemoteAddress());

			// UsernamePasswordAuthenticationToken에 넣었던 UserDetails 객체 반환
			UserDetails userVO = (UserDetails) authentication.getPrincipal();
			log.info("ID정보 : " + userVO.getUsername());
			log.info("권한정보 : " + userVO.getAuthorities());
			mav.addObject("mbr", userVO.getUsername());
		}

		return mav;
	}

	// 로그인페이지
	@GetMapping("/login")
	public ModelAndView login(ModelAndView mav, @RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception) {
		log.info("getLogin");
		mav.setViewName("login/login");
		mav.addObject("error", error);
		mav.addObject("exception", exception);

		return mav;
	}

	// 회원가입페이지
	@GetMapping("/signup")
	public ModelAndView register(ModelAndView mav) {
		log.info("getSignup");
		mav.setViewName("login/register");

		return mav;
	}

	// 회원가입 등록
	@PostMapping("/signup/join")
	public ResponseEntity<String> memberRegisting(@RequestBody MemberVO mvo, Model model) throws Exception {

		ResponseEntity<String> entity = null;
		try {
			mService.addMbr(mvo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 아이디 중복체크
	@RequestMapping(value = "/signup/idCheck", produces = "application/json; charset=utf-8")
	public ResponseEntity<String> idCheck(@RequestParam("m_id") String m_id) throws Exception {
		ResponseEntity<String> entity = null;

		if (mService.idChk(m_id)) {
			entity = new ResponseEntity<String>("중복된 ID입니다.", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("사용가능한 ID입니다.", HttpStatus.OK);
		}

		return entity;
	}

}
