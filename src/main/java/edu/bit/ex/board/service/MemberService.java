package edu.bit.ex.board.service;

import java.util.List;

import edu.bit.ex.board.vo.MemberVO;

public interface MemberService {

	// id 중복체크
	public boolean idChk(String m_id);

	// 화원가입
	public void addMbr(MemberVO mvo);

	public MemberVO getMember(String username);

	public List<String> getAuth(String username);

	public List<MemberVO> getMemberList();

	public void getMemberDelete(String m_id);
}
