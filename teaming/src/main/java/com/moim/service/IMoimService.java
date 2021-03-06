package com.moim.service;

import java.util.List;

import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.MoimSearchVO;
import com.moim.vo.MoimSearchVO_lank;
import com.moim.vo.MoimVO;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
public interface IMoimService {
	
	public List<MoimVO> getMoimList(MoimSearchVO searchVO);
	
	public List<MoimVO> getMoimListRank(MoimSearchVO_lank searchVO);
	
	public void registMoim(MoimVO Moim) throws BizNotEffectedException;

	public MoimVO getMoim(String moimCode) throws BizNotFoundException ;
	
	public void modifyMoim(MoimVO Moim) throws BizNotEffectedException, BizNotFoundException ;
	
	public void removeMoim(MoimVO Moim) throws BizNotEffectedException, BizNotFoundException;
	
	/**
	 * 모임이미지 업데이트용
	 * @param moim
	 * @param fileName
	 * @author ok
	 */
	public void updateMoimImage(MoimVO moim, String fileName) throws BizNotEffectedException;
	
	/**
	 * 모임 멤버용
	 * @param moimCode
	 * @param roleName
	 * @param searchVO
	 * @return UserVO
	 * @author juno
	 */
	public List<UserVO> getMemberList(String moimCode, String roleName, UserSearchVO searchVO) throws BizNotFoundException;
}
