package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.moim.vo.MoimSearchVO;
import com.moim.vo.MoimSearchVO_lank;
import com.moim.vo.MoimVO;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
@Mapper
public interface IMoimDao {
	public List<MoimVO> getMoimList(MoimSearchVO searchVO);
	
	public List<MoimVO> getMoimListRank(MoimSearchVO_lank searchVO);
	
	public MoimVO getMoim(String moimCode);

	public int insertMoim(MoimVO moim);

	public int updateMoim(MoimVO moim);

	public int deleteMoim(MoimVO moim);

	public int getMoimCount(MoimSearchVO searchVO);
	
	public int getMoimCountRank(MoimSearchVO_lank searchVO);
	
	public int updateMoimImage(@Param("moimCode") String moimCode, @Param("fileName") String fileName);
	
	public List<UserVO> getMemberList(UserSearchVO searchVO);
	
	public int getMemberCount(UserSearchVO searchVO);
	
	public int getSparemeberCount(String moimCode);
}
