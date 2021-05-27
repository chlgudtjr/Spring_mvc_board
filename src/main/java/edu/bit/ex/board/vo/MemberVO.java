package edu.bit.ex.board.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MemberVO {
	private String m_id;
	private String m_pw;
	private String authorities;
	private int enabled;

}
