package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class MoimMapVO {
	private String moimName;		/* 모임 이름 */
	private String moimAdress;	/* 통 주소 */
	private String moimCode;		/* 모임 코드 */
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	

	public String getMoimCode() {
		return moimCode;
	}


	public void setMoimCode(String moimCode) {
		this.moimCode = moimCode;
	}


	public String getMoimName() {
		return moimName;
	}
	public void setMoimName(String moimName) {
		this.moimName = moimName;
	}
	public String getMoimAdress() {
		return moimAdress;
	}
	public void setMoimAdress(String moimAdress) {
		this.moimAdress = moimAdress;
	}
	
	
}
