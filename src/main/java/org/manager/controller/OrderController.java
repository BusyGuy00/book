package org.manager.controller;

import org.manager.domain.OrderPageDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("order/*")
public class OrderController {

	@GetMapping("/orderlist/{userid}")
	public void orderListGet(@PathVariable("userid") String userid, OrderPageDTO oto, Model model) {
		System.out.println("memberId : " + oto);
		System.out.println("orders : " + oto.getOrders());
	}
	
}
