package org.manager.service;

import java.util.List;


import org.manager.domain.Criteria;
import org.manager.domain.ProductAttachDTO;
import org.manager.domain.ProductDTO;


public interface ProductService {
	//리스트
	public List<ProductDTO> getList(ProductDTO pto);
	//등록
	public void insert (ProductDTO pto);
	//상세보기 
	public ProductDTO read(int bookid);
	//게시글 수정
	public boolean update(ProductDTO pto);
	//삭제하기 
	public boolean delete(int bookid);
	
	//게시글 목록 조회 
	//BoardMapper에서 만든 Criteria cri를 넣어 주고 구현 하는 Impl에 넣어 준다. 
	public List<ProductDTO> getList(Criteria cri);
	//게시글 개수 조회  //Criteria cri 검색후의 데이터 개수 처리를 위해 추가 
	public int getTotal(Criteria cri); 
	//게시글 번호에 맞는 BoardAttachVO list 받기
	public List<ProductAttachDTO> getAttachList(Long bno);
	
	public List<ProductDTO> getProductsByCategory(String category);
	//List<ProductDTO> getProductsByCategory(String category);
	
}
