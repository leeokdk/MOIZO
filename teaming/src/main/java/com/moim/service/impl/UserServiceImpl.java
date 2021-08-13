package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moim.dao.IUserDao;
import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IUserService;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
@Service
public class UserServiceImpl implements IUserService {

	@Inject
	IUserDao userDao;
	
	@Override
	public List<UserVO> getUserList(UserSearchVO userSearchVO) {
		int totalCount = userDao.getUserCount(userSearchVO);
		userSearchVO.setTotalRowCount(totalCount);
		userSearchVO.pageSetting();
		return userDao.getUserList(userSearchVO);
	}

	@Override
	public void registUser(UserVO User) throws BizDuplicateKeyException, BizNotEffectedException {
		UserVO vo = userDao.getUser(User.getUserId());
		if (vo != null) {
			throw new BizDuplicateKeyException();
		} else {
			// insert
			int cnt = userDao.insertUser(User);
			if (cnt < 1) {
				throw new BizNotEffectedException();
			}
		}
	}

	@Override
	public UserVO getUser(String userId) throws BizNotFoundException {
		UserVO user = userDao.getUser(userId);
		if (user == null) {
			System.out.println("해당 유저가 없음.");
			throw new BizNotFoundException();			
		}
		return user;
	}

	@Override
	public void modifyUser(UserVO User) throws BizNotEffectedException, BizNotFoundException {
		UserVO vo = userDao.getUser(User.getUserId());
		if (vo == null) {
			throw new BizNotFoundException();
		}
		int cnt = userDao.updateUser(User);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void removeUser(UserVO User) throws BizNotEffectedException, BizNotFoundException {
		UserVO vo = userDao.getUser(User.getUserId());
		if (vo == null) {
			throw new BizNotFoundException();
		}
		int cnt = userDao.deleteUser(User);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

}
