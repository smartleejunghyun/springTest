package kr.smhrd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.smhrd.entity.Member;
import kr.smhrd.mapper.MemberMapper;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	public Member login(Member vo) {
		Member member = memberMapper.login(vo);
		return member;
	}
}
