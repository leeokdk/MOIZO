package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class AttentionVO {
	private String userId;                  /* 유저아이디*/
	private String hbCode;                  /* 관심사코드*/
	
	public AttentionVO(String userId, String userHobby) {
		this.userId = userId;
		this.hbCode = userHobby;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getHbCode() {
		return hbCode;
	}

	public void setHbCode(String hbCode) {
		this.hbCode = hbCode;
	}
	
	
}
