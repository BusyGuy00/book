package org.manager.domain;

import lombok.Data;

@Data
public class OrderPageItemDTO {
	/* 뷰로부터 전달받을 값 */
    private int bookid;
    
    private int count;
    
	/* DB로부터 꺼내올 값 */
    private String bookname;
    
    private int price;
    
	/* 만들어 낼 값 */
    private int salePrice;
    
    private int totalPrice;

    public void initSaleTotal() {
		this.salePrice = (int) (this.price);
		this.totalPrice = this.salePrice*this.count;
		
	}
    @Override
	public String toString() {
		return "OrderPageItemDTO [bookid=" + bookid + ", count=" + count + ", bookname=" + bookname
				+ ", price=" +price + ", salePrice=" + salePrice
				+ ", totalPrice=" + totalPrice + "]";
	}
}
