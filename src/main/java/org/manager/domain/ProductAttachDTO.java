package org.manager.domain;

import lombok.Data;

@Data
public class ProductAttachDTO {
	private String filename;
	private String uploadpath;
	private String uuid;
	private boolean image;
	private Long pno;
}
