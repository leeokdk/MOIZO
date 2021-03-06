package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class LocationVO {
	private String localBigCode;            /* 지역 대분류 코드*/
	private String localBigName;            /* 지역 대분류 이름*/
	private String localMidCode;            /* 지역 중분류 코드*/
	private String localMidName;            /* 지역 중분류 이름*/
	private String localSmallCode;          /* 지역 소분류 코드*/
	private String localSmallName;          /* 지역 소분류 이름*/

	public LocationVO(String localBigCode, String localMidCode) {
		this.localBigCode = localBigCode;
		this.localMidCode = localMidCode;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	public String getLocalBigCode() {
		return localBigCode;
	}

	public void setLocalBigCode(String localBigCode) {
		this.localBigCode = localBigCode;
	}

	public String getLocalBigName() {
		return localBigName;
	}

	public void setLocalBigName(String localBigName) {
		this.localBigName = localBigName;
	}

	public String getLocalMidCode() {
		return localMidCode;
	}

	public void setLocalMidCode(String localMidCode) {
		this.localMidCode = localMidCode;
	}

	public String getLocalMidName() {
		return localMidName;
	}

	public void setLocalMidName(String localMidName) {
		this.localMidName = localMidName;
	}

	public String getLocalSmallCode() {
		return localSmallCode;
	}

	public void setLocalSmallCode(String localSmallCode) {
		this.localSmallCode = localSmallCode;
	}

	public String getLocalSmallName() {
		return localSmallName;
	}

	public void setLocalSmallName(String localSmallName) {
		this.localSmallName = localSmallName;
	}
	
}
