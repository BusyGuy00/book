package org.manager.mapper;

import java.util.List;
import java.util.Map;

import org.manager.domain.Criteria;
import org.manager.domain.ProductDTO;

public interface ProductMapper {
	
	//제품 리스트 
	public List<ProductDTO> getList();
	
	//상품 insert
	public void insert (ProductDTO pto);
	
	//select
	public ProductDTO read(int pno);
	
	//update
	public int update (ProductDTO pto);
	
	//delete
	public int delete (int bookid);
	
	//페이징을 사용해서 조회 
	public List<ProductDTO> getListWithPaging(Criteria cri);
		
	//전체 데이터 개수 //Criteria cri 검색후의 데이터 개수 처리를 위해 추가 
	public int getTotalCount(Criteria cri);
		
	//insert메소드2 등록된 번호 받기 
	public void insertSelectKey(ProductDTO pto);
	
	//검색 연습 
	//Map<키: 스트링타입, 값: map타입>
	public List<ProductDTO> searchTest(Map<String, Map<String,String>> map);
	
	public List<ProductDTO> getProductsByCategory(String category);
}
