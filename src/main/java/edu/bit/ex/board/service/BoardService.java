package edu.bit.ex.board.service;

import java.util.List;

import edu.bit.ex.board.page.Criteria;
import edu.bit.ex.board.vo.BoardComment;
import edu.bit.ex.board.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> getList(Criteria cri);

	public int getTotal(Criteria cri);

	public BoardVO getContentView(int bId);

	public List<BoardComment> getComment(int bId);

	public int getDelete(int bId);

	public void getWrite(BoardVO bVO);

	public void getModify(BoardVO bVO);

	public void getHit(int getbId);

	public void commentInsert(BoardComment bcVO);

	public int commentRemove(int comment_id);

	public void commentUpdate(BoardComment bcVO);

}
