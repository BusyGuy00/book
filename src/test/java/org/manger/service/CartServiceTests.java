package org.manger.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.manager.domain.CartDTO;
import org.manager.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartServiceTests {

	@Autowired
	private CartService service;

	//등록 테스트
		@Test
		public void addCartTest() {
			//given
				String userid = "admin";
				int bookid = 22;
				int count = 5;
				
				CartDTO dto = new CartDTO(); 
				dto.setUserid(userid);
				dto.setBookid(bookid);
				dto.setCount(count);
			
			//when
				int result = service.addCart(dto);
			
			//then
				System.out.println("** result : " + result);
			
			
		}

}


