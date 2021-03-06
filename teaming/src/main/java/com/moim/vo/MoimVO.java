package com.moim.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.moim.common.valid.Modify;

public class MoimVO {
	@NotNull(groups = Modify.class)
	private String moimCode;                /* 모임코드*/
	@NotBlank(message = "모임 이름을 적어주세요")
	private String moimName;                /* 모임이름*/
	private String managerId;               /* 모임장아이디*/
	@NotNull(message = "모임 카테고리를 선택해주세요")
	private String hbCode;                  /* 모임카테고리*/
	private String moimLike;                /* 모임좋아요*/
	private String moimDelYn;               /* 모임삭제여부*/
	@NotBlank(message = "모임 소개를 적어주세요")
	private String moimIntroduce;           /* 모임소개*/
	private String moimImage;               /* 모임사진*/
	@NotNull(message = "모임 지역의 시/도를 선택해주세요")
	private String localBigCode;            /* 지역 대분류 코드*/
	@NotNull(message = "모임 지역의 시/군/구를 선택해주세요")
	private String localMidCode;            /* 지역 중분류 코드*/
	private String moimLimitGender;         /* 모임제한 성별*/
	private String moimLimitAge;            /* 모임제한 나이*/
	@NotBlank(message = "모임 인원은 필수입니다")
	private String moimLimitMaximum;        /* 모임제한 인원*/
	private String moimLimitAgeEnd;         /* 모임제한 나이 상한선*/
	private String moimColor;      			  /* 모임 대표 색깔*/
	
	
	// 지역이름 조인할 수 있게 변수 추가
	private String moimCategory;				/* 모임 카테고리 이름 */
	private String moimLocalName;				/* 모임 지역 이름 */
	private String moimBigName;					/* 모임 지역 이름(대분류) */
	
	// 현재모임 전체멤버
	private int moimMemberCount;
	
	// 내가 만든 모임 가입신청 명수
	private int moimSparemeberCount;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
	
	public int getMoimSparemeberCount() {
		return moimSparemeberCount;
	}



	public void setMoimSparemeberCount(int moimSparemeberCount) {
		this.moimSparemeberCount = moimSparemeberCount;
	}



	public int getMoimMemberCount() {
		return moimMemberCount;
	}



	public void setMoimMemberCount(int moimMemberCount) {
		this.moimMemberCount = moimMemberCount;
	}



	public String getMoimBigName() {
		return moimBigName;
	}



	public void setMoimBigName(String moimBigName) {
		this.moimBigName = moimBigName;
	}



	public String getMoimColor() {
		return moimColor;
	}



	public void setMoimColor(String moimColor) {
		this.moimColor = moimColor;
	}



	public String getMoimLimitAgeEnd() {
		return moimLimitAgeEnd;
	}



	public void setMoimLimitAgeEnd(String moimLimitAgeEnd) {
		this.moimLimitAgeEnd = moimLimitAgeEnd;
	}



	public String getMoimLimitGender() {
		return moimLimitGender;
	}



	public void setMoimLimitGender(String moimLimitGender) {
		this.moimLimitGender = moimLimitGender;
	}



	public String getMoimLimitAge() {
		return moimLimitAge;
	}



	public void setMoimLimitAge(String moimLimitAge) {
		this.moimLimitAge = moimLimitAge;
	}



	public String getMoimLimitMaximum() {
		return moimLimitMaximum;
	}



	public void setMoimLimitMaximum(String moimLimitMaximum) {
		this.moimLimitMaximum = moimLimitMaximum;
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
	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public String getHbCode() {
		return hbCode;
	}
	public void setHbCode(String hbCode) {
		this.hbCode = hbCode;
	}
	public String getMoimLike() {
		return moimLike;
	}
	public void setMoimLike(String moimLike) {
		this.moimLike = moimLike;
	}
	public String getMoimDelYn() {
		return moimDelYn;
	}
	public void setMoimDelYn(String moimDelYn) {
		this.moimDelYn = moimDelYn;
	}
	public String getMoimIntroduce() {
		return moimIntroduce;
	}
	public void setMoimIntroduce(String moimIntroduce) {
		this.moimIntroduce = moimIntroduce;
	}
	public String getMoimImage() {
		return moimImage;
	}
	public void setMoimImage(String moimImage) {
		this.moimImage = moimImage;
	}
	public String getLocalBigCode() {
		return localBigCode;
	}
	public void setLocalBigCode(String localBigCode) {
		this.localBigCode = localBigCode;
	}
	public String getLocalMidCode() {
		return localMidCode;
	}
	public void setLocalMidCode(String localMidCode) {
		this.localMidCode = localMidCode;
	}



	public String getMoimCategory() {
		return moimCategory;
	}



	public void setMoimCategory(String moimCategory) {
		this.moimCategory = moimCategory;
	}



	public String getMoimLocalName() {
		return moimLocalName;
	}



	public void setMoimLocalName(String moimLocalName) {
		this.moimLocalName = moimLocalName;
	}
	
	
}
