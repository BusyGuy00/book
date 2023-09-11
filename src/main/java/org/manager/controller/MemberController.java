package org.manager.controller;

import org.manager.domain.AuthVO;
import org.manager.domain.MemberVO;
import org.manager.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/member/*")
public class MemberController {
	@Setter(onMethod_= {@Autowired} )
	private MemberService mService;
	@Setter(onMethod_= {@Autowired} )
	private PasswordEncoder pwEncoder;
	
	@GetMapping("/memberwrite")
	public void writeGet() {
	}
	
	@PostMapping("/memberwrite")
	public String PostWrite(MemberVO mvo, AuthVO avo, RedirectAttributes rttr) {
		mvo.setUserpw(pwEncoder.encode(mvo.getUserpw()));
		mService.write(mvo, avo);
		return "redirect:/product/list";
	}

	 }
	
	
	

