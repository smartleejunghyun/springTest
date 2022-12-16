package kr.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;


public interface BoardMapper{

	//전체 리스트 가져오기
	public List<Board> getList(Criteria cri); // 추상메서드 ---->  SQL(Mapper.xml)
	
	//글 저장하기
	public void insert(Board vo);
	
	//글 상세보기
	public Board read(int idx);
	
	//글 삭제하기
	public int delete(int idx);
	
	//글 수정하기
	public void update(Board board);
	
	//조회수 증가시키기
	@Update("update tblReply set count=count+1 where idx=#{idx}")
	public void updateCount(int idx);
	
	// 같은 bgroup 에서 부모의 bseq보다 큰 값들을 +1 하는 메서드
	@Update("update tblReply set bseq = bseq + 1 where bgroup=#{bgroup} and bseq > #{bseq}")
	public void boardReplySeqUpdate(Board vo);
	
	//답글 달기 메서드
	public void insertReply(Board vo);
	
	//전체 게시글 개수 구하는 메서드
	
	public int countBoard(Criteria cri);



}
