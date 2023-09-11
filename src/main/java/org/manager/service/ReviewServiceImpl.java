package org.manager.service;

import java.util.List;

import org.manager.domain.ReviewDTO;
import org.manager.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	@Setter (onMethod_= {@Autowired})
	private ReviewMapper mapper;

	@Override
	public List<ReviewDTO> getReviewList(int bookid) {
		List<ReviewDTO> ReviewList = mapper.getReviewList(bookid);
		return ReviewList;
	}

	@Override
	public void reviewInsert(ReviewDTO rdto) {
		mapper.reviewInsert(rdto);
		
	}

	@Override
	public boolean reviewDelete(int rno) {
		
		return mapper.reviewDelete(rno);
		
	}
	
	
}
