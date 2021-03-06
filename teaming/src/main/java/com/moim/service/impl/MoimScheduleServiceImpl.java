package com.moim.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moim.dao.IMoimScheduleDao;
import com.moim.dao.IScheduleEnterListDao;
import com.moim.exception.BizMaximumExceedException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IMoimScheduleService;
import com.moim.vo.MoimScheduleSearchVO;
import com.moim.vo.MoimScheduleVO;


/**
 * searchVO 추가함
 * 
 * @author DNA
 * @since 2021.07.28
 */
@Service
public class MoimScheduleServiceImpl implements IMoimScheduleService{

	
	@Inject
	private IMoimScheduleDao moimScheduleDao;
	
	@Inject
	private IScheduleEnterListDao scheduleEnterDao;
	
	
	@Override
	public List<MoimScheduleVO> getScheduleList(MoimScheduleSearchVO searchVO) {
		int totalRowCount = moimScheduleDao.getScheduleCount(searchVO);
		System.out.println(totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		return moimScheduleDao.getScheduleList(searchVO);
	}

	@Override
	public MoimScheduleVO getSchedule(int mScheduleNo) throws BizNotFoundException {
		
		MoimScheduleVO moimSchedule = moimScheduleDao.getSchedule(mScheduleNo);
		
		if(moimSchedule == null) throw new BizNotFoundException();
		
		return moimSchedule;
	}


	@Override
	public void modifySchedule(MoimScheduleVO moimScheduleVO) throws BizNotFoundException, BizNotEffectedException {
		
		MoimScheduleVO moimSchedule = moimScheduleDao.getSchedule(moimScheduleVO.getmScheduleNo());
		if(moimSchedule == null) throw new BizNotEffectedException();
		
		// 글쓰기 버튼은 모임장만 보이기 때문에 수정 if조건은 걸지 않았음
		int cnt = moimScheduleDao.updateSchedule(moimScheduleVO);
		if(cnt < 1) throw new BizNotEffectedException();
		
	}

	@Override
	public void removeSchedule(MoimScheduleVO moimScheduleVO) throws BizNotFoundException, BizNotEffectedException {
		
		MoimScheduleVO moimSchedule = moimScheduleDao.getSchedule(moimScheduleVO.getmScheduleNo());
		if(moimSchedule == null) throw new BizNotEffectedException();
		
		int cnt = moimScheduleDao.deleteSchedule(moimScheduleVO);
		if(cnt < 1) throw new BizNotEffectedException();
	}

	@Override
	public void registSchedule(MoimScheduleVO moimScheduleVO) throws BizNotEffectedException {
		//moimScheduleVO.getmScheduleNo() 0
		int cnt = moimScheduleDao.insertSchedule(moimScheduleVO);
		
		//3 
		if(cnt < 1) throw new BizNotEffectedException();
		
	}

	@Override
	public MoimScheduleVO changeScheduleEnterMember(MoimScheduleVO moimScheduleVO) throws BizMaximumExceedException {
		// merge 문을 사용했기에 추가/삭제여부를 알기 어려움 
		scheduleEnterDao.mergeScheduleEnter(moimScheduleVO);
		// 스케쥴-사용자 변경내역을 스케쥴정보에 업데이트   
		moimScheduleDao.updateMoimScheduleEnterCount(moimScheduleVO);
		// TODO: 인원수 제한 및 체크여부 넘겨주기 
		MoimScheduleVO checkVO = moimScheduleDao.getSchedule(moimScheduleVO.getmScheduleNo() );
		if( checkVO != null && checkVO.getmScheduleEnterMax() < checkVO.getmScheduleEnter() ) {
			throw new BizMaximumExceedException("설정인원 : " + checkVO.getmScheduleEnterMax() + ", 현재 총 인원 : " + checkVO.getmScheduleEnter() + "으로 초과 오류 발생 " );
		}
		return checkVO;
	}
	
	@Override
	public List<MoimScheduleVO> getScheduleEnterList(MoimScheduleVO moimScheduleVO) {
		List<MoimScheduleVO> result = scheduleEnterDao.getScheduleEnterList(moimScheduleVO);
		return result;
	}

	@Override
	public List<MoimScheduleVO> getScheduleEnterByUser(MoimScheduleVO moimScheduleVO) {
		List<MoimScheduleVO> result = scheduleEnterDao.getScheduleEnterByUser(moimScheduleVO);
		return result;
	}
	
	

}
