package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class ManagerNoticeVO {
	private String moimCode;                /* 모임코드*/
	private int mNoticeNo;               	/* 게시글 넘버*/
	private String mNoticeTitle;            /* 게시글 제목*/
	private String mNoticeWriter;           /* 게시글 작성자*/
	private String mNoticeContent;          /* 게시글 내용*/
	private int mNoticeHit;              	/* 게시글 조회수*/
	private String mNoticeRegDate;          /* 게시글 등록날짜*/
	private String mNoticeModDate;          /* 게시글 수정날짜*/
	private String mNoticeDelYn;            /* 게시글 삭제여부*/
	private String boardCode;               /* 게시판 코드*/
	private int rNum;						/* 게시글 넘버 보여주기 */
	
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

	public int getmNoticeNo() {
		return mNoticeNo;
	}

	public void setmNoticeNo(int mNoticeNo) {
		this.mNoticeNo = mNoticeNo;
	}

	public String getmNoticeTitle() {
		return mNoticeTitle;
	}

	public void setmNoticeTitle(String mNoticeTitle) {
		this.mNoticeTitle = mNoticeTitle;
	}

	public String getmNoticeWriter() {
		return mNoticeWriter;
	}

	public void setmNoticeWriter(String mNoticeWriter) {
		this.mNoticeWriter = mNoticeWriter;
	}

	public String getmNoticeContent() {
		return mNoticeContent;
	}

	public void setmNoticeContent(String mNoticeContent) {
		this.mNoticeContent = mNoticeContent;
	}

	public int getmNoticeHit() {
		return mNoticeHit;
	}

	public void setmNoticeHit(int mNoticeHit) {
		this.mNoticeHit = mNoticeHit;
	}

	public String getmNoticeRegDate() {
		return mNoticeRegDate;
	}

	public void setmNoticeRegDate(String mNoticeRegDate) {
		this.mNoticeRegDate = mNoticeRegDate;
	}

	public String getmNoticeModDate() {
		return mNoticeModDate;
	}

	public void setmNoticeModDate(String mNoticeModDate) {
		this.mNoticeModDate = mNoticeModDate;
	}

	public String getmNoticeDelYn() {
		return mNoticeDelYn;
	}

	public void setmNoticeDelYn(String mNoticeDelYn) {
		this.mNoticeDelYn = mNoticeDelYn;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	public int getrNum() {
		return rNum;
	}

	public void setrNum(int rNum) {
		this.rNum = rNum;
	}


	
}
