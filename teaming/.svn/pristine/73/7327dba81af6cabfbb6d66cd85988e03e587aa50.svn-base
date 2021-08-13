package com.moim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.LoginVO;

/**
 * 
 * <b> Login_Table <b>
 * 4-4IRF ILoginService 참조
 * logincheck 없앰 / 준오
 * @author 다나
 *@since 2021.07.14
 */
public interface ILoginService {

	public void registUser(LoginVO login) throws BizDuplicateKeyException, BizNotEffectedException;
	
	public void registUserRole(LoginVO login) throws BizNotEffectedException;
	
	public void modifyLogin(LoginVO login) throws BizNotFoundException, BizNotEffectedException;
	
	public void removeLogin(LoginVO login) throws BizNotFoundException, BizNotEffectedException;
	
	public void removeRole(LoginVO login) throws BizNotFoundException, BizNotEffectedException;
	
	public String getUserRole(String id) throws BizNotFoundException;
	
	public Map<String, LoginVO> getUser(String userId, String userPassword) throws BizNotFoundException;
	
	// SPARE -> MEMBER 로 바꿀 때 쓰는 서비스
	public void modify(LoginVO login) throws BizNotFoundException, BizNotEffectedException;
	
}
 