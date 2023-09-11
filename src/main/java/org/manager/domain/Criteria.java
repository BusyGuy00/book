package org.manager.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	//public Criteria의 기본 생성자를 통해서 int pageNum에는 1페이지 int amount 10개로 지정 했다.
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	//배열로써 foreach를 돌려야 한해서 type를 배열로 만들어 준다 
	//검색조건을 배열로 만들어서 리턴 (한번에 처리하기 위함)
	public String[] getTypeArr() {		//split은 문자열을 배열로 만들어 준다
		return type == null ? new String[] {} : type.split("");
	}

}
