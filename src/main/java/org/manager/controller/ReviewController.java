package org.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.manager.domain.ReviewDTO;
import org.manager.service.ReviewService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("review/*")
@AllArgsConstructor
public class ReviewController {
	private ReviewService service;
	
	@PostMapping("/reviewInsert")
	public String reviewInsert (ReviewDTO rdto, HttpSession session) {
			service.reviewInsert(rdto);
			System.out.println("댓글 등록 성공");
			return "redirect:/product/list";
		}
		
	@PostMapping("/reviewRemove")
	@ResponseBody
	public ResponseEntity<String> reviewDelete (int rno){
		service.reviewDelete(rno);
		log.info(rno);
		return new ResponseEntity<String>("delete", HttpStatus.OK);
		}
	}
	








