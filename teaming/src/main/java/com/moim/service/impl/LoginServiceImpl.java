package com.moim.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.moim.dao.ILoginDao;
import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.ILoginService;
import com.moim.service.IUserService;
import com.moim.vo.LoginVO;
import com.moim.vo.UserVO;

/**
 * 
 * <b> Login_Table <b>
 *
 * 4-4IRF LoginServiceImpl 참조
 * 
 * @author 다나
 * @since 2021.07.14
 */
@Service
public class LoginServiceImpl implements ILoginService {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Inject
	ILoginDao loginDao;

	@Inject
	IUserService userService;

	// String type으로 바로 주면 joinController에서 user.setRole에 넣을 수 있음
	@Override
	public String getUserRole(String id) throws BizNotFoundException {
		return loginDao.getUserRole(id);
	}

	@Override
	public Map<String, LoginVO> getUser(String userId, String userPassword) throws BizNotFoundException {
		List<LoginVO> loginList = loginDao.getUser(userId);

		Map<String, LoginVO> loginMap = new HashMap<String, LoginVO>();
		for (LoginVO loginVO : loginList) {
			loginMap.put(loginVO.getMoimCode(), loginVO);
		}
		LoginVO user = loginMap.get("NOPE");
		if (user == null || !user.getUserId().equals(userId) || !user.getUserPassword().equals(userPassword)) {
			throw new BizNotFoundException();
		}
		return loginMap;
	}

	// 여기에서 해당 유저권한을 guest로 주어야함. / logindao 써야함. 쿼리문에서 GUEST로 주면 됌.
	@Override
	public void registUser(LoginVO login) throws BizDuplicateKeyException, BizNotEffectedException {
		List<LoginVO> vo = loginDao.getUser(login.getUserId());
		if (!vo.isEmpty()) {
			throw new BizDuplicateKeyException();
		} else {
			logger.debug("login", login);
			int cnt = loginDao.insertUserRole(login);
			if (cnt < 1) {
				throw new BizNotEffectedException();
			}
		}
	}

	@Override
	public void modifyLogin(LoginVO login) throws BizNotFoundException, BizNotEffectedException {
		List<LoginVO> vo = loginDao.getUser(login.getUserId());
		if (vo.get(0) == null) {
			throw new BizNotFoundException();
		}
		int cnt = loginDao.updateRole(login);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void removeLogin(LoginVO login) throws BizNotFoundException, BizNotEffectedException {
		List<LoginVO> vo = loginDao.getUser(login.getUserId());
		if (vo.get(0) == null) {
			throw new BizNotFoundException();
		}
		int cnt = loginDao.deleteLogin(login);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void registUserRole(LoginVO login) throws BizNotEffectedException {
		List<LoginVO> vo = loginDao.getUser(login.getUserId());
		logger.debug("login", login);
		int cnt = loginDao.insertUserRole(login);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void removeRole(LoginVO login) throws BizNotFoundException, BizNotEffectedException {
		List<LoginVO> vo = loginDao.getUser(login.getUserId());
		if (vo.get(0) == null) {
			throw new BizNotFoundException();
		}
		int cnt = loginDao.deleteRole(login);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void modify(LoginVO login) throws BizNotFoundException, BizNotEffectedException {
		List<LoginVO> vo = loginDao.getUser(login.getUserId());
		if (vo.get(0) == null) {
			throw new BizNotFoundException();
		}
		int cnt = loginDao.update(login);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}
	
}
