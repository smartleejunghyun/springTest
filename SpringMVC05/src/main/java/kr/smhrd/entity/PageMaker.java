package kr.smhrd.entity;

import lombok.Data;

@Data
public class PageMaker {

	private Criteria cri; //현재 페이지 번호와 한 페이지에 보여줄 게시글의 수
	private int totalCount; // 총 게시글의 수
	private int startPage; // 페이지 1~10 / 11~20
	private int endPage; // 페이지 그룹의 끝 페이지 번호(조절 가능)
	private boolean prev; //이전버튼(true, false) start페이지가 1이 아니면
	private boolean next; // 다음버튼(true, false) totalCount가 페이지값 * 10보다 많으면
	private int displayPageNum = 5; // 화면 하단에 보여지는 페이지의 수(페이지 그룹=10)
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPaging();
	}
	
	public void calcPaging() {
		//화면에 보일 마지막 페이지 번호
		//EndPage는 현재 페이지 를 10으로 나눈 값을 ceil한 값
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		
		
		startPage = (int)(endPage - displayPageNum+1);
		if(startPage<=0) {
			startPage=1;
		}
		
		// 3. 전체의 마지막 페이지 계산
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		
		// 4.화면에 보여질 마지막 페이지가 유효한지 체크
		if(endPage>tempEndPage) {
			endPage = tempEndPage;
		}
		//5. 이전 페이지 버튼의 존재 여부
		prev = (startPage==1) ? false : true;
		
		//6. 다음 페이지 버튼의 존재 여부
		next = (endPage<tempEndPage) ? true : false;
	}
}
