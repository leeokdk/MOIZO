package com.moim.service;

import java.util.List;

import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.GalleryVO;

/**
 * 
 * @author ok
 *
 */
public interface IGalleryService {
	public List<GalleryVO> getBoardList();
	public GalleryVO getBoard(int galleryNo) throws BizNotEffectedException;
	
	public int increseHit(int galleryNo) throws BizNotEffectedException;
	
	public int modifyBoard(GalleryVO galleryVO) throws BizNotFoundException, BizNotEffectedException;
	public int removeBoard(GalleryVO galleryVO) throws BizNotFoundException, BizNotEffectedException;
	public int registBoard(GalleryVO galleryVO) throws BizNotEffectedException;
	
}
