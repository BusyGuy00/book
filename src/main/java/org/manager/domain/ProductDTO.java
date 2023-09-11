package org.manager.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductDTO {
	private Long bookid;
	private Long price;
	private String pname;
	private String writer;
	private String category;
	private String filename;
	private String fullname;
	private Long count;
	private Date postdate;
	private String uploadpath;
}
