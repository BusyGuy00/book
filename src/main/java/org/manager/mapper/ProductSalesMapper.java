package org.manager.mapper;

import java.util.Date;
import java.util.List;


import org.manager.domain.ProductSalesVO;

public interface ProductSalesMapper {
		//제품 리스트 
		public List<ProductSalesVO> getSalesList(Date postdate);
		
		//insert
		public void salesInsert (ProductSalesVO pvo);
		
		//select
		public ProductSalesVO salesRead(int psno);
		
		//dayinsert
		public void daysales (ProductSalesVO pvo);
		
		//제품 리스트 
		public List<ProductSalesVO> getPriceList(String userid);
}
