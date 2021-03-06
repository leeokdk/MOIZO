package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.moim.dao.IHobbyDao;
import com.moim.dao.ILocationDao;
import com.moim.dao.ILoginDao;
import com.moim.dao.IMoimDao;
import com.moim.dao.IUserDao;
import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IMoimService;
import com.moim.service.IUserService;
import com.moim.vo.HobbyVO;
import com.moim.vo.LocationVO;
import com.moim.vo.MoimSearchVO;
import com.moim.vo.MoimSearchVO_lank;
import com.moim.vo.MoimVO;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;

/**
 * @author 준오
 * @since 2021.07.14 
 * @since 07.19 inject 및 메소드 수정
 */
@Service
public class MoimServiceImpl implements IMoimService {
	
	@Inject
	IMoimDao moimDao;
	@Inject
	ILoginDao loginDao;
	@Override
	public List<MoimVO> getMoimList(MoimSearchVO searchVO) {		
		int totalRowCount = moimDao.getMoimCount(searchVO);
		System.out.println(totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		return moimDao.getMoimList(searchVO);
	}

	@Override
	public void registMoim(MoimVO moim) throws BizNotEffectedException {
		int cnt = moimDao.insertMoim(moim);
		if (cnt < 1)
			throw new BizNotEffectedException();
		
//		// 첨부파일이 존재하는 경우 첨부파일 등록 , parentNo 설정 필요
//		List<AttachVO> atchList = free.getAttaches();
//		if(atchList != null) {
//			for (AttachVO vo : atchList) {
//				vo.setAtchParentNo(free.getBoNo());
//				//free의 boNo가 0인데 어떻게 하면 새로
//				//mybatis selectkey 사용 
//				attachDao.insertAttach(vo);
//			}
//		}
	}

	@Override
	public MoimVO getMoim(String moimCode) throws BizNotFoundException {
		MoimVO moimVO = moimDao.getMoim(moimCode);
		if (moimVO == null)
			throw new BizNotFoundException();
		return moimVO;
	}

	@Override
	public void modifyMoim(MoimVO moim) throws BizNotEffectedException, BizNotFoundException {
		MoimVO moimVO = moimDao.getMoim(moim.getMoimCode());
		if (moimVO == null)
			throw new BizNotFoundException(); 
		int cnt = moimDao.updateMoim(moim);
		if (cnt < 1)	throw new BizNotEffectedException();
	}

	@Override
	public void removeMoim(MoimVO moim) throws BizNotEffectedException, BizNotFoundException {
		MoimVO moimVO = moimDao.getMoim(moim.getMoimCode());
		if (moimVO == null)
			throw new BizNotFoundException(); 
		int cnt2 = loginDao.deleteMember(moim.getMoimCode());
		int cnt = moimDao.deleteMoim(moim);
		if (cnt < 1 || cnt2 < 1)	throw new BizNotEffectedException();
	}

	@Override
	public void updateMoimImage(MoimVO moim, String fileName) throws BizNotEffectedException {
		moimDao.getMoim(moim.getMoimCode());
		int cnt = moimDao.updateMoimImage(moim.getMoimCode(), fileName);
		if (cnt < 1) throw new BizNotEffectedException();
	}

	@Override
	public List<MoimVO> getMoimListRank(MoimSearchVO_lank searchVO) {
		int totalRowCount = moimDao.getMoimCountRank(searchVO);
		System.out.println(totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		return moimDao.getMoimListRank(searchVO);
	}

	@Override
	public List<UserVO> getMemberList(String moimCode, String roleName, UserSearchVO searchVO) throws BizNotFoundException {
		searchVO.setRoleName(roleName);
		searchVO.setMoimCode(moimCode);
		int totalCount = moimDao.getMemberCount(searchVO);
		searchVO.setTotalRowCount(totalCount);
		searchVO.pageSetting();
		return moimDao.getMemberList(searchVO);
	}

}
