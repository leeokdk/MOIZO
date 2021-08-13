package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class HobbyVO {
	private String hbCode;                  /* 관심사코드*/
	private String hbName;                  /* 관심사이름*/
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	public String getHbCode() {
		return hbCode;
	}

	public void setHbCode(String hbCode) {
		this.hbCode = hbCode;
	}

	public String getHbName() {
		return hbName;
	}

	public void setHbName(String hbName) {
		this.hbName = hbName;
	}

}
