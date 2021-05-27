package edu.bit.ex.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import edu.bit.ex.board.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RestController
@RequestMapping("/admin/*")
public class AdminController {

	@Autowired
	private MemberService mService;

	// 회원리스트조회
	@GetMapping("/memberList")
	public ModelAndView memberList(Authentication authentication, ModelAndView mav) {
		log.info("getMemberList");
		mav.setViewName("admin/memberList");
		mav.addObject("member", mService.getMemberList());

		if (authentication != null) {

			// UsernamePasswordAuthenticationToken에 넣었던 UserDetails 객체 반환
			UserDetails userVO = (UserDetails) authentication.getPrincipal();
			log.info("ID정보 : " + userVO.getUsername());
			log.info("권한정보 : " + userVO.getAuthorities());
			mav.addObject("mbr", userVO.getUsername());
		}

		return mav;
	}

	// 회원정보 삭제
	@DeleteMapping(value = "/memberList/{m_id}/delete")
	public ResponseEntity<String> boardDelete(@PathVariable("m_id") String m_id) {
		ResponseEntity<String> entity = null;
		log.info("CommentDelete...");

		try {
			mService.getMemberDelete(m_id);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

}
