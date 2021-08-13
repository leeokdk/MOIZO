package com.moim.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 
 *
 * @author DNA
 * @since 2021.07.29
 */
public class MoimScheduleSearchVO extends PagingVO2 {
	// 혹시 몰라서 페이징 VO 만들어봄
	
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
