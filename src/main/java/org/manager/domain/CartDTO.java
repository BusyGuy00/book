package org.manager.domain;

import lombok.Data;

@Data
public class CartDTO {
	private int cartid;
	private String userid;
	private int bookid;
	private int count;
	
	private String pname;
	private Long price;
	private String filename;
	private String fullname;
	
	private int salePrice;
	private int totalPrice;
	
	@Override
	public String toString() {
		return "CartDTO [cartid=" + cartid + ", userid=" + userid + ", bookid=" + bookid + ", count="
				+count + ", pname=" + pname + ", price=" +price +", salePrice=" + salePrice + ", totalPrice=" + totalPrice + "]";
	}
	public void initSaleTotal() {
		this.salePrice += this.price;
		this.totalPrice = this.salePrice*this.count;
	}
}
