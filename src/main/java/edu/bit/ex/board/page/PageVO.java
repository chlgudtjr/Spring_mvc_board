package edu.bit.ex.board.page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {
	private int startPage;
	private int endPage;
	private boolean next, prev;

	private int total;
	private Criteria cri;

	public PageVO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;

		// 최대 10페이지 단위로 보여주어 페이징을 처리한다.(100개 기준)
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0) * 10);
		this.startPage = (this.endPage - 10) + 1;

		// 만약 전체 게시글 수가 100개 미만이면 해당 페이지까지만 보여준다.
		int realEnd = (int) (Math.ceil((total * 1.0 / cri.getAmount())));
		if (realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		// 시작번호가 1보다 큰 경우 활성화시킨다.
		this.prev = this.startPage > 1;
		// realEnd가 끝 번호 보다 큰 경우 활성화시킨다.
		this.next = this.endPage < realEnd;
	}

	// 해당 페이지 번호에 따라 URL 뒤에 붙게한다.
	public String makeQuery(int page) {
		UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("pageNum", page).queryParam("amount", cri.getAmount())
				.build();
		return uriComponentsBuilder.toUriString();
	}

}
