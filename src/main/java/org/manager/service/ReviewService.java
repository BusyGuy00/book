package org.manager.service;

import java.util.List;

import org.manager.domain.ReviewDTO;

public interface ReviewService {
	//리뷰 리스트 
	public List<ReviewDTO> getReviewList(int bookid);
		
	//리류 쓰기 
	public void reviewInsert (ReviewDTO rdto);
		
	//리뷰 삭제 
	public boolean reviewDelete (int rno);
}
