package com.moim.service;

import java.util.List;

import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.FreeSearchVO;
import com.moim.vo.FreeVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
public interface IFreeService {
	
	public List<FreeVO> getFreeList(FreeSearchVO searchVO);
	
	public FreeVO getFree(int freeNo) throws BizNotFoundException;
	
	public void increaseHit(int boNo) throws BizNotEffectedException;
	
	public void modifyFree(FreeVO free) throws BizNotFoundException, BizNotEffectedException;
	
	public void removeFree(FreeVO free) throws BizNotFoundException, BizNotEffectedException;
	
	public void registFree(FreeVO free) throws BizNotEffectedException;
}
