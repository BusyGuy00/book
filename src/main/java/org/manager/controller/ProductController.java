package org.manager.controller;


import java.io.Console;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.manager.domain.Criteria;
import org.manager.domain.PageDTO;
import org.manager.domain.ProductDTO;
import org.manager.domain.ProductSalesVO;
import org.manager.service.ProductService;
import org.manager.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/product/*")
@AllArgsConstructor
public class ProductController {
	@Setter(onMethod_= {@Autowired})
	private ProductService service;
	@Setter(onMethod_= {@Autowired})
	private ReviewService rservice;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri, String category )  {
		
		
		
		if(category != null) {
			model.addAttribute("list", service.getProductsByCategory(category));
		}else {
			model.addAttribute("list", service.getList(cri));
		}
		//전체 게시글 수 받아오기 
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri,total)); 
		
	}
	@GetMapping("/insert")
	public void insert() {
	}
	@PostMapping("/insert")
	public String postinsert(ProductDTO pdto, RedirectAttributes rttr)
	{
		log.info("==================================================");
		log.info("register : " + pdto);
		log.info("==================================================");
		service.insert(pdto);
		//보내는 메소드
		rttr.addAttribute("result",pdto.getBookid());
		//rttr.addAttribute("result","등록");
		return "redirect:/product/list";
	}
	//게시글 상세 보기 
	//게시글 조회 상세보기 + 수정하기 페이지 추가 
	@GetMapping({"/view","/modify"})
	public void get(@ModelAttribute("bookid")int bookid, Model model) {
		//인증정보
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//리뷰
		model.addAttribute("reviewlist", rservice.getReviewList(bookid));
		
		model.addAttribute("board",service.read(bookid));
	}
	@GetMapping("/getSalesForDate")
	@ResponseBody
	public String getSalesForDate(@RequestParam String date) {
	    // date를 이용하여 해당 날짜에 대한 매출 데이터를 조회하는 작업 수행
	    // 조회한 매출 데이터를 HTML 형식으로 구성하여 리턴
	    String salesData = "<div>해당 날짜의 매출 데이터: " + date + "</div>";
	    return salesData;
	} 
	
	//게시글 삭제 요청 처리 
		@PostMapping("/remove")
		public String remove(int bookid, String uploadPath , String fileName) {
			//업로드 사진 삭제
			deleteFile(uploadPath, fileName);
			service.delete(bookid);
			return "redirect:/product/list";
		}
		//파일 삭제 메소드 
		private void deleteFile(String uploadPath, String fileName) {
			Path file = Paths.get("c:\\upload\\"+uploadPath+"\\"+fileName);
			try {
				Files.delete(file);
				Path thumbNail = Paths.get("c:\\upload\\"+uploadPath+"\\s_"+fileName);
				Files.delete(thumbNail);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		//게시글 수정 요청 처리
		@PostMapping("/modify")
		public String modify(ProductDTO pto) {
			//값 받아오는지 확인
			log.info("===================수정==================");
			log.info(pto);
			log.info("===================수정==================");
			//게시글 수정 요청 처리
			service.update(pto);
			return "redirect:/product/list";
		}
	
//		@GetMapping("/category/{category}")
//		public String cartPageGet(@PathVariable("category") String category, Model model) {
//			log.info(category);
//			model.addAttribute("category", service.getProductsByCategory(category));
//			
//			return "redirect:/product/list";
//		}
		@GetMapping("/category")
		public void getCategoryProducts(String category, Model model) {
		    
		    log.info("그린그린그린");
		    log.info(category);
		   
		    List<ProductDTO> products = service.getProductsByCategory(category);
		    log.info(products);
		    model.addAttribute("list",products);
		    
		}
//		 @GetMapping("/category")
//		    public ResponseEntity<List<ProductDTO>> getProductsByCategory(@RequestParam("category") String category) {
//		        List<ProductDTO> products = service.getProductsByCategory(category);
//
//		        return new ResponseEntity<>(products, HttpStatus.OK);
//		 }
}
