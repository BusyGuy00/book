package org.manager.service;

import java.util.List;

import org.manager.domain.CartDTO;

public interface CartService {

//	장바구니 추가 
	public int addCart(CartDTO cart);
//	장바구니 리스트 
	public List<CartDTO> getCartList(String userid);
//	장바구니 품목 삭제 
	public int deleteCart (int cartid);
// 장바구니의 모든 항목 삭제
    public int deleteAllCartItems(String userid);
}