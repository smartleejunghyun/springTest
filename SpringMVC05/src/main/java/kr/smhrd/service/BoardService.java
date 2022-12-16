package kr.smhrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
import kr.smhrd.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired
	BoardMapper boardMapper;

	// 글 가져오는 메소드
	public List<Board> getList(Criteria cri) {

		return boardMapper.getList(cri);
	}

	// 글 저장 메소드
	public void register(Board vo) {

		boardMapper.insert(vo);
	}

	// 글 상세 읽기 메소드
	public Board get(int idx) {

		Board board = boardMapper.read(idx);
		boardMapper.updateCount(idx);
		return board;
	}

	// 글 삭제하기 메소드
	public boolean remove(int idx) {

		int cnt = boardMapper.delete(idx);

		if (cnt > 0) {
			return true;
		} else {
			return false;
		}
	}

	// 글 수정하기 메소드
	public void modify(Board board) {
		boardMapper.update(board);
		// 조회수 1증가

	}

	// 답글 다는 메소드
	public void reply(Board vo) {
		// 원글(부모글)에 대한 정보 가져오기
		Board parent = boardMapper.read(vo.getIdx());
		// 답글 정보 만들기(bgroup, bseq, blevel)
		vo.setBgroup(parent.getBgroup());
		System.out.println(vo.getBgroup());
		vo.setBseq(parent.getBseq() + 1);
		vo.setBlevel(parent.getBlevel() + 1);
		// 답글 들어갈 자리 만들기, (기존에 있는 현재seq보다 높은 애들 +1 시켜주기)
		boardMapper.boardReplySeqUpdate(parent);
		boardMapper.insertReply(vo);
	}
	
	//전체 게시글 개수 만드는 메소드
	public int countBoard(Criteria cri) {
		return boardMapper.countBoard(cri);
	}

}
