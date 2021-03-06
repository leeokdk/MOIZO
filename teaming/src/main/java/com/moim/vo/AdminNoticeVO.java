package com.moim.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.moim.common.valid.Modify;

public class AdminNoticeVO {
	@NotNull(groups = Modify.class)
	private int aNoticeNo;               /* 게시글 넘버*/
	@NotBlank(message = "제목을 적어주세요")
	private String aNoticeTitle;            /* 게시글 제목*/
	private String aNoticeWriter;           /* 게시글 작성자*/
	@NotBlank(message = "글의 내용을 적어주세요")
	private String aNoticeContent;          /* 게시글 내용*/
	private int aNoticeHit;             	 /* 게시글 조회수*/
	private String aNoticeRegDate;          /* 게시글 등록날짜*/
	private String aNoticeModDate;          /* 게시글 수정날짜*/
	private String aNoticeDelYn;            /* 게시글 삭제여부*/
	private String boardCode;				/* 게시판 타입*/
	
	private String aNoticeWriterName; /* 게시글 작성자 이름 */
	private String rnum; /*게시글 순서*/
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
	
	public String getRnum() {
		return rnum;
	}



	public void setRnum(String rnum) {
		this.rnum = rnum;
	}



	public String getaNoticeWriterName() {
		return aNoticeWriterName;
	}

	public void setaNoticeWriterName(String aNoticeWriterName) {
		this.aNoticeWriterName = aNoticeWriterName;
	}

	public String getBoardType() {
		return boardCode;
	}

	public void setBoardType(String boardCode) {
		this.boardCode = boardCode;
	}

	public int getaNoticeNo() {
		return aNoticeNo;
	}
	public void setaNoticeNo(int aNoticeNo) {
		this.aNoticeNo = aNoticeNo;
	}
	public String getaNoticeTitle() {
		return aNoticeTitle;
	}
	public void setaNoticeTitle(String aNoticeTitle) {
		this.aNoticeTitle = aNoticeTitle;
	}
	public String getaNoticeWriter() {
		return aNoticeWriter;
	}
	public void setaNoticeWriter(String aNoticeWriter) {
		this.aNoticeWriter = aNoticeWriter;
	}
	public String getaNoticeContent() {
		return aNoticeContent;
	}
	public void setaNoticeContent(String aNoticeContent) {
		this.aNoticeContent = aNoticeContent;
	}
	public int getaNoticeHit() {
		return aNoticeHit;
	}
	public void setaNoticeHit(int aNoticeHit) {
		this.aNoticeHit = aNoticeHit;
	}
	public String getaNoticeRegDate() {
		return aNoticeRegDate;
	}
	public void setaNoticeRegDate(String aNoticeRegDate) {
		this.aNoticeRegDate = aNoticeRegDate;
	}
	public String getaNoticeModDate() {
		return aNoticeModDate;
	}
	public void setaNoticeModDate(String aNoticeModDate) {
		this.aNoticeModDate = aNoticeModDate;
	}
	public String getaNoticeDelYn() {
		return aNoticeDelYn;
	}
	public void setaNoticeDelYn(String aNoticeDelYn) {
		this.aNoticeDelYn = aNoticeDelYn;
	}
	
	
}
