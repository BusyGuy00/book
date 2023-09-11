package org.manager.mapper;

import java.util.List;

import org.manager.domain.DaySalesVO;


public interface DaySalesMapper {
	//제품 리스트 
	public List<DaySalesVO> daySalesList();
			
	//insert
	public void datSalesInsert (DaySalesVO dvo);
}
