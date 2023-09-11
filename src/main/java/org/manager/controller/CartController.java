package org.manager.controller;

import java.io.Console;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.manager.domain.CartDTO;
import org.manager.domain.MemberVO;
import org.manager.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/cart/*")
public class CartController {
	@Setter(onMethod_= {@Autowired})
	private CartService cartService;
	
	@PostMapping("/add")
	@ResponseBody
	public String addCartPost(CartDTO cart, HttpServletRequest request) {
//		//로그인 체크 
//		HttpSession session = request.getSession();
//		MemberVO mvo = (MemberVO)session.getAttribute("member");
//		if(mvo == null) {
//			return "5";
//	}
		
		// 카트 등록 
		int result = cartService.addCart(cart);
		log.info(cart);
		return result + "" ;
		
	}
	@GetMapping("/cartlist/{userid}")
	public String cartPageGet(@PathVariable("userid") String userid, Model model) {
		
		model.addAttribute("cartInfo", cartService.getCartList(userid));
		
		return "/cart/cartlist";
	}
	@PostMapping("/delete")
	@ResponseBody
	public  ResponseEntity<String> deleteCart (int bookid) {
		cartService.deleteCart(bookid);
		log.info(bookid);
		return  new ResponseEntity<String>("deleted" , HttpStatus.OK);
	}
	
	
	@PostMapping("/deleteAll")
	@ResponseBody
	public ResponseEntity<String> deleteAllCartItems(String userid) {
	    cartService.deleteAllCartItems(userid);
	    return new ResponseEntity<String>("All items deleted", HttpStatus.OK);
	}
}

