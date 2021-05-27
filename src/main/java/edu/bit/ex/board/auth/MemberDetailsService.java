package edu.bit.ex.board.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import edu.bit.ex.board.mapper.LoginMapper;
import edu.bit.ex.board.vo.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberDetailsService implements UserDetailsService {

	@Autowired
	private LoginMapper loginMapper;

	@Override
	public UserDetails loadUserByUsername(String m_id) throws UsernameNotFoundException {
		// 최종적으로 리턴해야할 객체
		MemberDetails memberDetails = new MemberDetails();

		// 사용자 정보 select
		MemberVO userInfo = loginMapper.getMember(m_id);

		// 사용자 정보 없으면 null 처리
		if (userInfo == null) {
			return null;

			// 사용자 정보 있을 경우 로직 전개 (userDetails에 데이터 넣기)
		} else {
			memberDetails.setUsername(userInfo.getM_id());
			memberDetails.setPassword(userInfo.getM_pw());

			// 사용자 권한 select해서 받아온 List<String> 객체 주입
			memberDetails.setAuthorities(loginMapper.getAuth(m_id));
		}

		return memberDetails;
	}

}
