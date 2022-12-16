package kr.smhrd.entity;

import lombok.Data;

//게시물의 번호, 제목, 내용, 작성자, 업데이트 시간, 조회수 / 답글
//필요한 데이터들 모델링
@Data
public class Board {

	
	private int idx;
	//추가
	private String memId; //회원의 아이디
	private String title;
	private String content;
	private String writer;
	private String indate;
	private int count;
	private int bgroup;
	private int bseq; //답글의 순서는 오름차순으로 정렬
	private int blevel;
	private int bdelete;
	
	
}
