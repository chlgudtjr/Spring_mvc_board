package edu.bit.ex.board.page;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	// 검색 변수 2개 선언
	private String type;
	private String keyword;

	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	// 검색조건이 각 글자(T:제목, C:내용 , W: 작성지)로 구성되어 있으므로 검색 조건을 배열로 만들어 한번에 처리하기 위함.
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
