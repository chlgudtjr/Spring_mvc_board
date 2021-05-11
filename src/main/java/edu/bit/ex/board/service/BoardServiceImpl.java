package edu.bit.ex.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.bit.ex.board.mapper.BoardMapper;
import edu.bit.ex.board.page.Criteria;
import edu.bit.ex.board.vo.BoardVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("list Service");
		return mapper.getList(cri);
	}

	@Override
	public BoardVO getContentView(int bId) {
		log.info("ContentView Service");
		return mapper.getContentView(bId);
	}

	@Override
	public int getDelete(int bId) {
		log.info("getDelete Service");
		return mapper.getDelete(bId);
	}

	@Override
	public void getWrite(BoardVO bVO) {
		log.info("getWrite Service");
		mapper.getWrite(bVO);

	}

	@Override
	public void getModify(BoardVO bVO) {
		log.info("getModify Service");
		mapper.getModify(bVO);

	}

	@Override
	public void getReply(BoardVO bVO) {
		log.info("getReply Service");
		mapper.getReply(bVO);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("getTotal Service");
		return mapper.getTotal(cri);
	}

	@Override
	public void getHit(int getbId) {
		log.info("getHit Service");
		mapper.getHit(getbId);

	}

}
