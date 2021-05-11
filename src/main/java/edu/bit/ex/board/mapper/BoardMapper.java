package edu.bit.ex.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.bit.ex.board.page.Criteria;
import edu.bit.ex.board.vo.BoardVO;

@Mapper
public interface BoardMapper {

	public List<BoardVO> getList(Criteria cri);

	public BoardVO getContentView(int bId);

	public int getDelete(int bId);

	public void getWrite(BoardVO bVO);

	public void getModify(BoardVO bVO);

	public void getReply(BoardVO bVO);

	public void replyShape(BoardVO bVO);

	public int getTotal(Criteria cri);

	public void getHit(int bId);

}
