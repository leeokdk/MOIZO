package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moim.dao.IAdminNoticeDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IAdminNoticeService;
import com.moim.vo.AdminNoticeSearchVO;
import com.moim.vo.AdminNoticeVO;

/**
 * 
 * @author ok
 *
 */
@Service
public class AdminNoticeServiceImpl implements IAdminNoticeService {
	
	@Inject
	IAdminNoticeDao adminNoticeDao; 

	@Override
	public List<AdminNoticeVO> getBoardList(AdminNoticeSearchVO searchVO) {
		int totalRowCount = adminNoticeDao.getBoardCount(searchVO);
		System.out.println(totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		return adminNoticeDao.getBoardList(searchVO);
	}

	@Override
	public AdminNoticeVO getBoard(int aNoticeNo) throws BizNotFoundException {
		AdminNoticeVO aNotice = adminNoticeDao.getBoard(aNoticeNo);
		if (aNotice == null) {
			throw new BizNotFoundException();
		}
		return aNotice;
	}

	@Override
	public void increseHit(int aNoticeNo) throws BizNotEffectedException {
		int cnt = adminNoticeDao.increseHit(aNoticeNo);
		if (cnt < 1) { 
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void modifyBoard(AdminNoticeVO aNotice) throws BizNotFoundException, BizNotEffectedException {
		AdminNoticeVO vo = adminNoticeDao.getBoard(aNotice.getaNoticeNo());
		if (vo == null) {
			throw new BizNotFoundException();
		}
		int cnt = adminNoticeDao.updateBoard(aNotice);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void removeBoard(AdminNoticeVO aNotice) throws BizNotFoundException, BizNotEffectedException {
		AdminNoticeVO vo = adminNoticeDao.getBoard(aNotice.getaNoticeNo());
		if (vo == null) {
			throw new BizNotFoundException();
		}
		int cnt = adminNoticeDao.deleteBoard(aNotice);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
	}

	@Override
	public void registBoard(AdminNoticeVO aNotice) throws BizNotEffectedException {
		int cnt = adminNoticeDao.insertBoard(aNotice);
		if (cnt < 1) {
			throw new BizNotEffectedException();
		}
		// 첨부파일이 존재하는 경우 첨부파일 등록 , parentNo 설정 필요
//		List<AttachVO> atchList = bo.getAttaches();
//		if (atchList != null) {
//			for (AttachVO vo : atchList) {
//				vo.setAtchParentNo(bo.getBoNo());
//				attachDao.insertAttach(vo);
//			}
//		}
	}

}
