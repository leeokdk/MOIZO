package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moim.dao.IManagerNoticeDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IManagerNoticeService;
import com.moim.vo.ManagerNoticeSearchVO;
import com.moim.vo.ManagerNoticeVO;
/**
 * 
 * @author ok -> DNA
 * @since 2021.07.20
 */
@Service
public class ManagerNoticeServiceImpl implements IManagerNoticeService {
	
	@Inject
	IManagerNoticeDao managerNoticeDao;

	@Override
	public List<ManagerNoticeVO> getBoardList(ManagerNoticeSearchVO searchVO) {
		// 총 row개수 구하기 + row개수 세팅, pageSetting, setting된 걸로 해당 
		// ManagerNoticeVO List 구하기
		int totalRowCount = managerNoticeDao.getBoardCount(searchVO);
		System.out.println(totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();

		
		return managerNoticeDao.getBoardList(searchVO);
	}

	@Override
	public ManagerNoticeVO getBoard(int mNoticeNo) throws BizNotFoundException {
		
		ManagerNoticeVO ManagerNotice = managerNoticeDao.getBoard(mNoticeNo);
			if (ManagerNotice == null) throw new BizNotFoundException();
			
			return ManagerNotice;
	}

	@Override
	public void increaseHit(int mNoticeNo) throws BizNotEffectedException {
		
		int cnt = managerNoticeDao.increaseHit(mNoticeNo);
		if(cnt < 1) throw new BizNotEffectedException();
		
	}

	@Override
	public void modifyBoard(ManagerNoticeVO managerNotice) throws BizNotFoundException, BizNotEffectedException {
		
		
		ManagerNoticeVO vo = managerNoticeDao.getBoard(managerNotice.getmNoticeNo());
		
		if(vo == null) throw new BizNotEffectedException();
		
		// 글쓰기 버튼은 모임장만 보이기 때문에 수정 if조건은 걸지 않았음
		int cnt = managerNoticeDao.updateBoard(managerNotice);
		if(cnt < 1) throw new BizNotEffectedException();
		
	}

	@Override
	public void removeBoard(ManagerNoticeVO managerNotice) throws BizNotFoundException, BizNotEffectedException {
	
		ManagerNoticeVO vo = managerNoticeDao.getBoard(managerNotice.getmNoticeNo());
		
		if(vo == null) throw new BizNotEffectedException();
		
		// 글쓰기 버튼은 모임장만 보이기 때문에 수정 if조건은 걸지 않았음
		int cnt = managerNoticeDao.deleteBoard(managerNotice);
		if(cnt < 1) throw new BizNotEffectedException();
		
	}

	@Override
	public void registBoard(ManagerNoticeVO managerNotice) throws BizNotEffectedException {
	
		int cnt = managerNoticeDao.insertBoard(managerNotice); 
		if (cnt <1) throw new BizNotEffectedException();
		
		// TODO : 첨부파일 추가하는 부분
		
//		List<AttachVO> atchList = free.getAttaches();
//		if (atchList != null) {
//			for (AttachVO vo : atchList) {
//				vo.setAtchParentNo(free.getBoNo());
//				attachDao.insertAttach(vo);
//			}
//		}
		
	}
	
	
}
