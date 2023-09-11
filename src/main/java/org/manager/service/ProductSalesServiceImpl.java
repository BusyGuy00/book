package org.manager.service;

import java.util.Date;
import java.util.List;

import org.manager.domain.ProductDTO;
import org.manager.domain.ProductSalesVO;
import org.manager.mapper.ProductMapper;
import org.manager.mapper.ProductSalesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ProductSalesServiceImpl implements ProductSalesService {
	@Setter (onMethod_= {@Autowired} )
	private ProductMapper mapper;
	@Setter (onMethod_= {@Autowired} )
	private ProductSalesMapper smapper;
	
	@Override
	public List<ProductSalesVO> daysale(Date postdate) {
		 List<ProductSalesVO> productList = smapper.getSalesList(postdate);
		return productList;
	}

	@Override
	public void dayinsert(ProductSalesVO pvo) {
		smapper.daysales(pvo);
		
	}

	@Override
	public List<ProductSalesVO> pricesale(String userid) {
		List<ProductSalesVO> saleList = smapper.getPriceList(userid);
		return saleList;
	}
	

}
