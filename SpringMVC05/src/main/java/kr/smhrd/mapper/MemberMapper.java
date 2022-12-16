package kr.smhrd.mapper;

import org.apache.ibatis.annotations.Select;

import kr.smhrd.entity.Member;

public interface MemberMapper {

	@Select("select * from tblMember where memId=#{memId} and memPwd=#{memPwd}")
	public Member login(Member vo);
}
