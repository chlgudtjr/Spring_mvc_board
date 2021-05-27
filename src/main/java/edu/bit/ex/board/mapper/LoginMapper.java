package edu.bit.ex.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.bit.ex.board.vo.MemberVO;

@Mapper
public interface LoginMapper {

	// id 중복체크
	public int idChk(String m_id);

	// 회원가입
	public void addMbr(MemberVO mvo);

	public MemberVO getMember(String m_id);

	public List<String> getAuth(String m_id);

	public List<MemberVO> getMemberList();

	public void getMemberDelete(String m_id);

}
