package org.manager.security;



import org.manager.domain.MemberVO;
import org.manager.mapper.MemberMapper;
import org.manager.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService {
	@Setter(onMethod_= {@Autowired} )
	private MemberMapper mapper;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//MemberMapper를 사용해서 MemberVO를 조회 하고 
		//MemberVO인스턴스가 있으면 UserDetails으로 변환해서 반환 
		MemberVO mvo = mapper.read(username);
		log.info(mvo);
		return mvo == null ? null : new CustomUser(mvo);
	}
}
