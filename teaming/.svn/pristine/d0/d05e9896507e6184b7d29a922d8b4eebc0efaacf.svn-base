package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.FreeSearchVO;
import com.moim.vo.FreeVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
@Mapper
public interface IFreeDao {
	public List<FreeVO> getFreeList(FreeSearchVO memSearchVO);

	public FreeVO getFree(int freeNo);

	public int increaseHit(int freeNo);
	
	public int insertFree(FreeVO free);

	public int updateFree(FreeVO free);

	public int deleteFree(FreeVO free);

	public int getFreeCount(FreeSearchVO memSearchVO);
}
