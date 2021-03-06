package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moim.dao.IFreeDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IFreeService;
import com.moim.vo.FreeSearchVO;
import com.moim.vo.FreeVO;
/**
 * @author 준오
 * @since 2021.07.14 
 */
@Service
public class FreeServiceImpl implements IFreeService {

	@Inject
	IFreeDao freeDao;
	
	@Override
	public List<FreeVO> getFreeList(FreeSearchVO searchVO) {
		searchVO.setRowSizePerPage(4);
		int totalRowCount = freeDao.getFreeCount(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		System.out.println(searchVO.toString());
		return freeDao.getFreeList(searchVO);
	}

	@Override
	public FreeVO getFree(int freeNo) throws BizNotFoundException {
		FreeVO free = freeDao.getFree(freeNo);
		if(free==null) throw new BizNotFoundException();
		return free;
	}

	@Override
	public void increaseHit(int freeNo) throws BizNotEffectedException {
		int cnt = freeDao.increaseHit(freeNo);
		if(cnt < 1) throw new BizNotEffectedException();
	}

	@Override
	public void registFree(FreeVO free) throws BizNotEffectedException {
		int cnt = freeDao.insertFree(free);
		if (cnt < 1) throw new BizNotEffectedException();
	}

	@Override
	public void modifyFree(FreeVO free) throws BizNotFoundException, BizNotEffectedException {
		FreeVO vo = freeDao.getFree(free.getFreeNo());
		if(vo == null) throw new BizNotFoundException();
		int cnt = freeDao.updateFree(free);
		if(cnt<1) throw new BizNotEffectedException();
	}

	@Override
	public void removeFree(FreeVO free) throws BizNotFoundException, BizNotEffectedException {
		FreeVO vo = freeDao.getFree(free.getFreeNo());
		if(vo == null) throw new BizNotFoundException();
		int cnt = freeDao.deleteFree(vo);
		if(cnt<1) throw new BizNotEffectedException();
		}
}
