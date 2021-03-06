package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.HobbyVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
@Mapper
public interface IHobbyDao {
	public List<HobbyVO> getHobbyCode();
	public HobbyVO getHobbyCodebyRanNum(int randN);
	public String getHobbyName(String hbCode);
}
