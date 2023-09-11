package org.manager.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.manager.domain.CartDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CartMapperTests {

	@Autowired
	private CartMapper mapper;
	
	@Test
	public void addCart() {
		String userid = "admin";
		int bookid = 71;
		int count = 2;
		
		CartDTO cart = new CartDTO();
		cart.setUserid(userid);
		cart.setBookid(bookid);
		cart.setCount(count);
		
		int result = 0;
		//result = mapper.addCart(cart);
		
		System.out.println("결과 : " + result);
		
	}	
	
	/* 카트 삭제 */

	@Test
	public void deleteCartTest() {
		int cartid = 2;
		
		mapper.deleteCart(cartid);
	}
	/* 카트 수량 수정 */

	@Test
	public void modifyCartTest() {
		int cartid = 3;
		int count = 5;
		
		CartDTO cart = new CartDTO();
		cart.setCartid(cartid);
		cart.setCount(count);
		
		mapper.modifyCount(cart);
		
	}
	/* 카트 목록 */ 

	@Test
	public void getCartTest() {
		String userid = "admin";
		
		
		List<CartDTO> list = mapper.getCart(userid);
		for(CartDTO cart : list) {
			System.out.println(cart);
			cart.initSaleTotal();
			System.out.println("init cart : " + cart);
		}
	}
	@Test
	public void checkCartTest() {
		
		String userid = "admin";
		int bookid = 71;
		
		CartDTO cart = new CartDTO();
		cart.setUserid(userid);
		cart.setBookid(bookid);
		
		CartDTO resutlCart = mapper.checkCart(cart);
		System.out.println("결과 : " + resutlCart);
		
	}
}

