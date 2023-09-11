package org.manager.controller;

import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.manager.domain.ProductDTO;
import org.manager.domain.ProductSalesVO;
import org.manager.service.ProductSalesService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/sale/*")
@AllArgsConstructor
public class ProductSalesController {
	private ProductSalesService service;
	@GetMapping("/pricelist/{userid}")
	public String priceList(Model model, @PathVariable("userid") String userid) {
		
		model.addAttribute("list", service.pricesale(userid));
		
		return "/sale/pricelist";
	}
	
	@GetMapping("/salelist")
	public String saleList(@RequestParam("postdate") String encodedPostdate, Model model) {
        try {
            String decodedPostdate = URLDecoder.decode(encodedPostdate, "UTF-8");
            SimpleDateFormat dateFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
            Date postdate = dateFormat.parse(decodedPostdate);
            
            List<ProductSalesVO> aa = service.daysale(postdate);
            model.addAttribute("list", service.daysale(postdate));
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
        }
        return "/sale/salelist";
    }
	
	@PostMapping("/saleinsert")
	public String saleinsert (
			RedirectAttributes rttr,
			ProductSalesVO pvo,
			@RequestParam("pname") List<String> pnames,
			@RequestParam("count") List<String> count,
			@RequestParam("fullname") List<String> fullname,
			@RequestParam("price") List<String> price,
			@RequestParam("pricesales") List<String> pricesales,
			@RequestParam("cartid") List<String> cartid,
			@RequestParam("userid") List<String> userid

			) {
			for (int i = 0; i < pnames.size(); i++) {
			pvo.setPname(pnames.get(i));
			pvo.setCount(count.get(i));
			pvo.setFullname(fullname.get(i));
			pvo.setPrice(price.get(i));
			pvo.setPricesales(pricesales.get(i));
			pvo.setCartid(cartid.get(i));
			pvo.setUserid(userid.get(i));
			service.dayinsert(pvo);
			rttr.addAttribute("result",pvo.getPno());
			rttr.addAttribute("userid",userid.get(1));
			

			}
       
			return "redirect:/sale/pricelist/{userid}";
	}
}
	

