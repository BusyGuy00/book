package org.manager.service;



import java.util.List;

import org.manager.domain.AuthVO;
import org.manager.domain.MemberVO;
import org.manager.mapper.MemberAuthMapper;
import org.manager.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
@Repository 
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_= {@Autowired} )
	private MemberMapper mMapper;
	@Setter(onMethod_= {@Autowired})
	private MemberAuthMapper AMapper;
	@Setter(onMethod_= {@Autowired} )
	private PasswordEncoder pwEncoder;
	
	@Override
	public List<MemberVO> getMemberList() {
		List<MemberVO> memberList =  mMapper.getList();
		return memberList;
	}
	
	@Override
	public void write(MemberVO mvo, AuthVO avo) {

		mvo.setUserpw(pwEncoder.encode(mvo.getUserpw()));
		mMapper.memberwrite(mvo);
		AMapper.Ainsert(avo);
	}

	@Override
	public MemberVO view(String userid) {
		return mMapper.memberview(userid);
	}
	

}
