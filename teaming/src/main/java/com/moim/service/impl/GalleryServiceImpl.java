package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import com.moim.dao.IGalleryDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IGalleryService;
import com.moim.vo.GalleryVO;
/**
 * 
 * @author ok
 *
 */
public class GalleryServiceImpl implements IGalleryService {
	
//	@Inject
	IGalleryDao galleryDao;
	
	@Override
	public List<GalleryVO> getBoardList() {
		return null;
	}

	@Override
	public GalleryVO getBoard(int galleryNo) throws BizNotEffectedException {
		return null;
	}

	@Override
	public int increseHit(int galleryNo) throws BizNotEffectedException {
		return 0;
	}

	@Override
	public int modifyBoard(GalleryVO galleryVO) throws BizNotFoundException, BizNotEffectedException {
		return 0;
	}

	@Override
	public int removeBoard(GalleryVO galleryVO) throws BizNotFoundException, BizNotEffectedException {
		return 0;
	}

	@Override
	public int registBoard(GalleryVO galleryVO) throws BizNotEffectedException {
		return 0;
	}

}
