package org.manager.service;

import java.util.List;

import org.manager.domain.CartDTO;
import org.manager.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class CartServiceImpl implements CartService {

	@Setter (onMethod_= {@Autowired})
	private CartMapper cMapper;

	@Override
	public int addCart(CartDTO cart) {
		CartDTO checkCart = cMapper.checkCart(cart);
		if(checkCart != null) {
			return 2;
		}
				
		try {
			return cMapper.addCart(cart);
		} catch (Exception e) {
			return 0;
		}
	}

	@Override
	public List<CartDTO> getCartList(String userid) {
		List<CartDTO> cart = cMapper.getCart(userid);
		for(CartDTO dto : cart) {
			dto.initSaleTotal();
		}
		return cart;
	}

	@Override
	public int deleteCart(int cartid) {
		return cMapper.deleteCart(cartid);
	}
	
	@Override
    public int deleteAllCartItems(String userid) {
        return cMapper.deleteAllCartItems(userid);
    }
	
}
