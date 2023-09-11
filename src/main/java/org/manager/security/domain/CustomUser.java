package org.manager.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.manager.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	//CustomUser는 User를 상속받으므로 , 부모 클래스의 생성자를 호출해야만 
		//정상적인 객체를 생성할 수 있다.
		//AuthVO --- > GrantedAuthority 객체로 변환해서 사용할 것이다.
		private MemberVO member;
		//로그인이 된것을 Long타입으로 만들어 알려주는 것이다. 
		private static final long serialVersionUID =1L;
		public CustomUser( String username, String password, 
				Collection<? extends GrantedAuthority> authorities) {
			super(username, password, authorities);
		}
		public CustomUser(MemberVO mvo) {
			super(mvo.getUserid(), mvo.getUserpw(), mvo.getAuthList()
					.stream() //stream()은getAuthList를 흐르게 해준다  
					.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
					.collect(Collectors.toList()));
					this.member = mvo;
		}
}
