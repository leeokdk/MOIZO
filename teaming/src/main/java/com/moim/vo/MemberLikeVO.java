package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class MemberLikeVO {
	private String memberId;                /* 멤버아이디*/
	private String galleryNo;               /* 사진 넘버*/
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getGalleryNo() {
		return galleryNo;
	}

	public void setGalleryNo(String galleryNo) {
		this.galleryNo = galleryNo;
	}
	
	
}
