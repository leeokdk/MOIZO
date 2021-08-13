package com.moim.service;

import java.util.List;

import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;
/**
 * 
 * @author 준오
 * @since 2021.07.14 
 */
public interface IUserService {

	public List<UserVO> getUserList(UserSearchVO userSearchVO);
	
	public void registUser(UserVO User) throws BizDuplicateKeyException, BizNotEffectedException;

	public UserVO getUser(String userId) throws BizNotFoundException ;
	
	public void modifyUser(UserVO User) throws BizNotEffectedException, BizNotFoundException ;
	
	public void removeUser(UserVO User) throws BizNotEffectedException, BizNotFoundException;
	
}
