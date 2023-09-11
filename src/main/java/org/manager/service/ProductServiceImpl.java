package org.manager.service;

import java.util.List;

import org.manager.domain.Criteria;
import org.manager.domain.ProductAttachDTO;
import org.manager.domain.ProductDTO;
import org.manager.domain.ProductSalesVO;
import org.manager.mapper.ProductAttachMapper;
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
public class ProductServiceImpl implements ProductService {
	@Setter (onMethod_= {@Autowired} )
	private ProductMapper mapper;
	@Setter (onMethod_= {@Autowired} )
	private ProductSalesMapper smapper;
	@Setter (onMethod_= {@Autowired} )
	private ProductAttachMapper attachMapper;
	
	@Override
	public List<ProductDTO> getList(ProductDTO pto) {
		List<ProductDTO> productList = mapper.getList();
		
		return productList;
	}

	@Override
	public void insert(ProductDTO pto) {
		mapper.insert(pto);
	}

	@Override
	public ProductDTO read(int bookid) {
		ProductDTO pto = mapper.read(bookid);
		return pto;
	}

	@Override
	public boolean update(ProductDTO pto) {
		return mapper.update(pto) == 1;
	}

	@Override
	public boolean delete(int bookid) {
		
		return mapper.delete(bookid) == 1;
	}
	
	@Override
	//riteria cri를 넣고 메소드를 getListWithPaging(cri);으로 수정 해준다.
	public List<ProductDTO> getList(Criteria cri) {
		log.info("리스트 출력");
		return mapper.getListWithPaging(cri);
	}
	@Override //Criteria cri 검색후의 데이터 개수 처리를 위해 추가 
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<ProductAttachDTO> getAttachList(Long bno) {
		log.info("첨부리스트 게시글 번호 : " + bno);
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<ProductDTO> getProductsByCategory(String category) {
			log.info("카테고리 리스트");
			 return mapper.getProductsByCategory(category);
	}
	
	
}
