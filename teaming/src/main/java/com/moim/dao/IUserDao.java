package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
@Mapper
public interface IUserDao {
	public List<UserVO> getUserList(UserSearchVO userSearchVO);

	public UserVO getUser(String userId);

	public int insertUser(UserVO user);

	public int updateUser(UserVO user);

	public int deleteUser(UserVO user);

	public int getUserCount(UserSearchVO userSearchVO);

	public String getUserRoleByUserId(String userId);
}
