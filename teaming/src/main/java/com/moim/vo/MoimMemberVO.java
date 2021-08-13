package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class MoimMemberVO {
	private String memberId;                /* 멤버아이디 */
	private String moimDelYn;               /* 모임탈퇴여부 */
	private String moimCode;                /* 모임코드 */
	private String userName;             	/* 이름 */
	private String userPic;                 /* 프로필사진*/
	private String userIntroduce;           /* 소개글*/
	private String userRole;				/* 모임 내 역할 */

	
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

	public String getMoimDelYn() {
		return moimDelYn;
	}

	public void setMoimDelYn(String moimDelYn) {
		this.moimDelYn = moimDelYn;
	}

	public String getMoimCode() {
		return moimCode;
	}

	public void setMoimCode(String moimCode) {
		this.moimCode = moimCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPic() {
		return userPic;
	}

	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}

	public String getUserIntroduce() {
		return userIntroduce;
	}

	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	
}
