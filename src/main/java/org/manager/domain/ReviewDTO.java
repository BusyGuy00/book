package org.manager.domain;

import lombok.Data;

@Data
public class ReviewDTO {

	private Long rno;
	private String userid;
	private String content;
	private String score;
	private Long bookid;
}
