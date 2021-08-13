package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class BoardTypeVO {
	private String boardCode;               /* 게시판 코드*/

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}
	
	
}
