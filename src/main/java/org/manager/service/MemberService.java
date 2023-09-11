package org.manager.service;



import java.util.List;

import org.manager.domain.AuthVO;
import org.manager.domain.MemberVO;

public interface MemberService {
	
	//회원 목록 페이지
	public List<MemberVO> getMemberList();
	
	public void write(MemberVO mvo, AuthVO avo);
	
	public MemberVO view (String userid);
	
}
