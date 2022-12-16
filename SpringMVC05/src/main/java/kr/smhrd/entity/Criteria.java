package kr.smhrd.entity;

import lombok.Data;

@Data
public class Criteria {

	private int page; // 현재 페이지 번호
	private int perPageNum; //페이지당 몇개의 게시글을? 10
	private String type; //3가지
	private String keyword;
	
	public Criteria() {
		this.page=1;
		this.perPageNum = 5;
	}
	//현재 페이지의 게시글의 시작번호(=1)
	public int getPageStart() {
		return (this.page-1)*perPageNum;
	}
}
