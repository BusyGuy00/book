package org.manager.service;

import java.util.List;

import org.manager.domain.DaySalesVO;
import org.manager.domain.ProductDTO;
import org.manager.domain.ProductSalesVO;
import org.manager.mapper.DaySalesMapper;
import org.manager.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class DaySalesServiceImpl implements DaySalesService{
	@Setter (onMethod_= {@Autowired} )
	private ProductMapper mapper;
	@Setter (onMethod_= {@Autowired} )
	private DaySalesMapper dmapper;
	
	@Override
	public List<ProductDTO> daysales(ProductDTO pto) {
		List<ProductDTO> productList = mapper.getList();
		return productList;
	}
	@Override
	public void daysalesinsert(DaySalesVO dvo) {
		dmapper.datSalesInsert(dvo);
		
	}
}
