package com.moim.service;

import java.util.List;

import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.ManagerNoticeSearchVO;
import com.moim.vo.ManagerNoticeVO;

/**
 * 
 * @author ok-> DNA
 * @since 2021.07.20
 */
public interface IManagerNoticeService {

	public List<ManagerNoticeVO> getBoardList(ManagerNoticeSearchVO managerNoticeSearchVO);

	public ManagerNoticeVO getBoard(int mNoticeNo) throws BizNotFoundException;

	public void increaseHit(int mNoticeNo) throws BizNotEffectedException;

	public void modifyBoard(ManagerNoticeVO managerNoticeVO) throws BizNotFoundException, BizNotEffectedException;

	public void removeBoard(ManagerNoticeVO managerNoticeVO) throws BizNotFoundException, BizNotEffectedException;

	public void registBoard(ManagerNoticeVO managerNoticeVO) throws BizNotEffectedException;

}
