package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class LoginVO {
	private String userId;             /* 유저아이디 */
	private String roleName;           /* 권한 이름 */
	private String userName;           /* 유저 이름 */
	private String userPassword;       /* 유저 패스워드 */
	private String moimCode;           /* 모임 코드 */
	private String userPic;	

	public LoginVO() {
		
	}
	
	public LoginVO(String userId, String roleName, String userName, String userPassword, String moimCode, String userPic) {
		this.userId = userId;
		this.roleName = roleName;
		this.userName = userName;
		this.userPassword = userPassword;
		this.moimCode = moimCode;
		this.userPic = userPic;
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

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getMoimCode() {
		return moimCode;
	}

	public void setMoimCode(String moimCode) {
		this.moimCode = moimCode;
	}

	public String getUserPic() {
		return userPic;
	}

	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}

	
}
