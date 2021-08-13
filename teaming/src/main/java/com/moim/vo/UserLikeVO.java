package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class UserLikeVO {
	private String userId;                  /* 유저 아이디*/
	private String moimCode;                /* 소모임 코드*/

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

	public String getMoimCode() {
		return moimCode;
	}

	public void setMoimCode(String moimCode) {
		this.moimCode = moimCode;
	}

	
}
