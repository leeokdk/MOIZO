package com.moim.vo;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.moim.common.valid.Step;

public class UserVO {
	@NotBlank(message = "id 필수", groups = {Step.class})
	private String userId;                  /* 유저아이디*/
	
	@NotBlank(message = "비밀번호 필수", groups = {Step.class})
	@Size(max = 15, min = 2, message = "2글자 이상 15글자 미만으로 입력해주세요.")
	private String userPassword;            /* 비밀번호*/
	
	@NotBlank(message = "이메일 필수", groups = {Step.class})
	@Email(message = "이메일 형식이 아닙니다.")
	private String userEmail;             /* 이메일정보*/
			
	@NotBlank(message = "이름 필수", groups = {Step.class})
	private String userName;                /* 이름*/
	
	@NotBlank(message = "성별 필수", groups = {Step.class})
	private String userGender;              /* 성별*/
	
	@NotBlank(message = "나이 필수", groups = {Step.class})
	private String userAge;                 /* 생년월일*/
	
	@NotBlank(message = "지역코드 필수", groups = {Step.class})
	private String localBigCode;            /* 지역 대분류 코드*/
	@NotBlank(message = "지역코드 필수", groups = {Step.class})
	private String localMidCode;            /* 지역 중분류 코드*/
	@NotBlank(message = "지역코드 필수", groups = {Step.class})
	private String localSmallCode;          /* 지역 소분류 코드*/
	
	@NotBlank(message = "프로필 필수", groups = {Step.class})
	private String userPic;                 /* 프로필사진*/
	
	// AttetionVO에 넣어줌
	@NotBlank(message = "취미 필수", groups = {Step.class})
	private String userHobby;
	
	@NotBlank(message = "소개글 필수", groups = {Step.class})
	@Size(max = 50, min = 5, message = "5글자 이상 50글자 미만으로 입력해주세요.")
	private String userIntroduce;           /* 소개글*/
	
	private String userDelYn;               /* 계정탈퇴여부*/
	
	
	// hobby이름 가져오기
	private String userHobbyNm;
	
	
	// 지역 이름 가져오기
	private String localBigNm;            /* 지역 대분류 이름*/
	private String localMidNm;            /* 지역 중분류 이름*/
	private String localSmallNm;          /* 지역 소분류 이름*/
	// 회원가입 시, 약관에 체크하기 위한 필드 생성 (join)
	@NotBlank(message = "체크하세요.", groups = Step.class)					// grups는 step1에서만 만들겠다는 뜻
	private String agreeYn;				/* 이용약관 (필수) */
	
	@NotBlank(message = "체크하세요.", groups = Step.class)
	private String privacyYn;			/* 개인정보 (필수) */
	
	private String eventYn;				/* 이벤트알람 (선택) */
	
	// 회원가입 시, 아이디 중복, 이메일확인 과정 validation
	@NotBlank(message = "아이디 중복 체크하세요.", groups = Step.class)					// grups는 step1에서만 만들겠다는 뜻
	private String idCheckYn;				/* 이용약관 (필수) */
	
	@NotBlank(message = "이메일 체크하세요.", groups = Step.class)
	private String emailCheckYn;			/* 개인정보 (필수) */
	
	
	public String getUserHobby() {
		return userHobby;
	}

	public void setUserHobby(String userHobby) {
		this.userHobby = userHobby;
	}

	
	
	// DB에 있는 필드 넣기
	private String userRole;
	
	
	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
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

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}


	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getLocalBigCode() {
		return localBigCode;
	}

	public void setLocalBigCode(String localBigCode) {
		this.localBigCode = localBigCode;
	}

	public String getUserIntroduce() {
		return userIntroduce;
	}

	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserAge() {
		return userAge;
	}

	public void setUserAge(String userAge) {
		this.userAge = userAge;
	}

	public String getUserDelYn() {
		return userDelYn;
	}

	public void setUserDelYn(String userDelYn) {
		this.userDelYn = userDelYn;
	}

	public String getUserPic() {
		return userPic;
	}

	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}

	public String getLocalMidCode() {
		return localMidCode;
	}

	public void setLocalMidCode(String localMidCode) {
		this.localMidCode = localMidCode;
	}

	public String getLocalSmallCode() {
		return localSmallCode;
	}

	public void setLocalSmallCode(String localSmallCode) {
		this.localSmallCode = localSmallCode;
	}

	public String getUserHobbyNm() {
		return userHobbyNm;
	}

	public void setUserHobbyNm(String userHobbyNm) {
		this.userHobbyNm = userHobbyNm;
	}

	public String getAgreeYn() {
		return agreeYn;
	}

	public void setAgreeYn(String agreeYn) {
		this.agreeYn = agreeYn;
	}

	public String getPrivacyYn() {
		return privacyYn;
	}

	public void setPrivacyYn(String privacyYn) {
		this.privacyYn = privacyYn;
	}

	public String getEventYn() {
		return eventYn;
	}

	public void setEventYn(String eventYn) {
		this.eventYn = eventYn;
	}

	public String getIdCheckYn() {
		return idCheckYn;
	}

	public void setIdCheckYn(String idCheckYn) {
		this.idCheckYn = idCheckYn;
	}

	public String getEmailCheckYn() {
		return emailCheckYn;
	}

	public void setEmailCheckYn(String emailCheckYn) {
		this.emailCheckYn = emailCheckYn;
	}

	public String getLocalBigNm() {
		return localBigNm;
	}

	public void setLocalBigNm(String localBigNm) {
		this.localBigNm = localBigNm;
	}

	public String getLocalMidNm() {
		return localMidNm;
	}

	public void setLocalMidNm(String localMidNm) {
		this.localMidNm = localMidNm;
	}

	public String getLocalSmallNm() {
		return localSmallNm;
	}

	public void setLocalSmallNm(String localSmallNm) {
		this.localSmallNm = localSmallNm;
	}
	
}
