package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.LoginVO;

/**
 * 새로 생성함.
 * @author 준오
 * @since 2021.07.16
 */

@Mapper
public interface ILoginDao {
	public String getUserRole(String id);
	
	public List<LoginVO> getUser(String userId); 
	
	public int insertUserRole(LoginVO login);
	
	public int updateRole(LoginVO login);
	
	public int deleteRole(LoginVO login);
	
	public int deleteLogin(LoginVO login);
	
	public int update(LoginVO login);
	
	public int deleteMember(String moimCode);
}
