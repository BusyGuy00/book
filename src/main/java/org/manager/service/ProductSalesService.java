package org.manager.service;

import java.util.Date;
import java.util.List;

import org.manager.domain.ProductDTO;
import org.manager.domain.ProductSalesVO;

public interface ProductSalesService {

	//사용자 구매 현황 리스트 
	public List<ProductSalesVO> daysale (Date postdate);
	//일 매출 등록
	public void dayinsert (ProductSalesVO pvo);
	//사용자 금액 리스트
	public List<ProductSalesVO> pricesale (String userid);
	
	
}
