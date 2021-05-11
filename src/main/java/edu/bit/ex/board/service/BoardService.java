package edu.bit.ex.board.service;

import java.util.List;

import edu.bit.ex.board.page.Criteria;
import edu.bit.ex.board.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> getList(Criteria cri);

	public BoardVO getContentView(int bId);

	public int getDelete(int bId);

	public void getWrite(BoardVO bVO);

	public void getModify(BoardVO bVO);

	public void getReply(BoardVO bVO);

	public int getTotal(Criteria cri);

	public void getHit(int getbId);

}
