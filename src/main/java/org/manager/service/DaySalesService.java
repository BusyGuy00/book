package org.manager.service;

import java.util.List;

import org.manager.domain.DaySalesVO;
import org.manager.domain.ProductDTO;


public interface DaySalesService {
	//일 매출 등록 하기 위한 리스트
	public List<ProductDTO> daysales (ProductDTO pto);
	
	//일 매출 등록 
	public  void daysalesinsert (DaySalesVO dvo);
}
