package com.moim.reply.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.moim.vo.PagingVO;

/**
 * 
 * @author DNA
 * @since 2021.07.20
 */
public class ReplySearchVO extends PagingVO{
	// 댓글은 검색 하지 않고, 10개씩 출력하기 위해 pagingVO 상속 받음 
	
	private String reCode;
	private int reParentNo;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE);
	}

	public String getReCode() {
		return reCode;
	}

	public void setReCode(String reCode) {
		this.reCode = reCode;
	}

	public int getReParentNo() {
		return reParentNo;
	}

	public void setReParentNo(int reParentNo) {
		this.reParentNo = reParentNo;
	}
	
	
	
}
