package org.manager.mapper;

import java.util.List;

import org.manager.domain.CartDTO;

public interface CartMapper {
	/* 카트 추가 */
	public int addCart(CartDTO cart) throws Exception  ;
	
	/* 카트 삭제 */
	public int deleteCart(int cartid);
	
	/* 카트 수량 수정 */
	public int modifyCount(CartDTO cart);
	
	/* 카트 목록 */
	public List<CartDTO> getCart(String userid);	
	
	/* 카트 확인 */
	public CartDTO checkCart(CartDTO cart);
	
	// 장바구니의 모든 항목 삭제
    public int deleteAllCartItems(String userid);
}
