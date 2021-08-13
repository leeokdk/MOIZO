package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 
 *
 * @author DNA
 * @since 2021.07.22
 */
public class ManagerNoticeSearchVO extends PagingVO2 {
	//소모임 공지는 검색 없고, 3개씩 출력하는 것을 목표로 함 
	
	private String moimCode;
	private String searchWord;
	private String searchType;
	
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
	
	public String getSearchWord() {
		return searchWord;
	}
	
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
	public String getSearchType() {
		return searchType;
	}
	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}


	
}
