package org.manager.mapper;


import java.util.List;

import org.manager.domain.MemberVO;

public interface MemberMapper {

	//리스트
	public List<MemberVO> getList();
	
	public MemberVO read(String userid);

	public void memberwrite(MemberVO mvo);

	public MemberVO memberview (String userid);
}
