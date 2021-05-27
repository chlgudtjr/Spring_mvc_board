package edu.bit.ex.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import edu.bit.ex.board.mapper.LoginMapper;
import edu.bit.ex.board.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private LoginMapper loginMapper;

	@Autowired
	PasswordEncoder passEncoder;

	// id 중복체크
	@Override
	public boolean idChk(String m_id) {
		int cnt = loginMapper.idChk(m_id);
		if (cnt == 0) {
			return false;
		} else {
			return true;
		}
	}

	// 회원가입 등록처리
	@Override
	public void addMbr(MemberVO mvo) {

		String pw = passEncoder.encode(mvo.getM_pw());
		log.info("encoded password >>>>>> " + pw);
		mvo.setM_pw(pw);

		loginMapper.addMbr(mvo);

	}

	@Override
	public MemberVO getMember(String username) {
		log.info("getMember");
		return loginMapper.getMember(username);
	}

	@Override
	public List<String> getAuth(String username) {
		log.info("getAuth");
		return loginMapper.getAuth(username);
	}

	@Override
	public List<MemberVO> getMemberList() {
		log.info("getMemberList");
		return loginMapper.getMemberList();
	}

	@Override
	public void getMemberDelete(String m_id) {
		log.info("getMemberList");
		loginMapper.getMemberDelete(m_id);

	}

}
