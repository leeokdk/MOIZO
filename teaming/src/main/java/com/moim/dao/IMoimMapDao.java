package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.MoimMapVO;

@Mapper
public interface IMoimMapDao {
	public List<MoimMapVO> getMoimMapList();
}
