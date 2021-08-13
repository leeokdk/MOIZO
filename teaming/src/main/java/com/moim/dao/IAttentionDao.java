package com.moim.dao;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.AttentionVO;
/**
 * 
 * @author 준오
 * @since 2021.07.14 
 */
@Mapper
public interface IAttentionDao {
	public AttentionVO getMemberHobby(String userId);
	
	public int updateHobby(AttentionVO attentionVO);
	
	public int insertHobby(AttentionVO attentionVO);
	
}
