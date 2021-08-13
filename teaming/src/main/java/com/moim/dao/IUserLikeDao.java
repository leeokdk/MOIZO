package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.UserLikeVO;
import com.moim.vo.UserVO;

/**
 * 소모임 좋아요 기능.
 * @author ok
 * @since 2021.07.14
 */
@Mapper
public interface IUserLikeDao {
	public int getUserLikeCount(String moimCode);
	public List<UserLikeVO> getUserLike(String userId);
	public int insertUserLike(UserLikeVO like);
	public int deleteUserLike(UserLikeVO like);
	public int searchUserLike(UserLikeVO like);
	
}
