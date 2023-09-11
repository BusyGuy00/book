package org.manager.mapper;

import java.util.List;

import org.manager.domain.ProductAttachDTO;

public interface ProductAttachMapper {
	//등록
	public void insert(ProductAttachDTO DTO);
	//삭제
	public void delete(String uuid);
	//조회
	public List<ProductAttachDTO> findByBno(Long pno);
	//게시글에 해당하는 레코드 삭제 
	public void deleteAll(Long pno);
}
