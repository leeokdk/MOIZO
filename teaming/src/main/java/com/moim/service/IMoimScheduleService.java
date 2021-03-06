package com.moim.service;

import java.util.List;

import com.moim.exception.BizMaximumExceedException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.MoimScheduleSearchVO;
import com.moim.vo.MoimScheduleVO;
/**
 * 
 * searchVO 추가함
 * 
 * @author DNA
 * @since 2021.07.31
 */
public interface IMoimScheduleService {

	public List<MoimScheduleVO> getScheduleList(MoimScheduleSearchVO searchVO);
	
	public MoimScheduleVO getSchedule(int mScheduleNo) throws BizNotFoundException;

	public void modifySchedule(MoimScheduleVO moimScheduleVO) throws BizNotFoundException, BizNotEffectedException;

	public void removeSchedule(MoimScheduleVO moimScheduleVO) throws BizNotFoundException, BizNotEffectedException;

	public void registSchedule(MoimScheduleVO moimScheduleVO) throws BizNotEffectedException;
	


	/**
	 * 해당 스케쥴의 참여자 목록을 조회  
	 * @param enterListVO 모임코드+스케쥴아이디
	 * @return
	 */
	public List<MoimScheduleVO> getScheduleEnterList(MoimScheduleVO moimScheduleVO );

	/**
	 * 해당 스케쥴에 사용자 참여 처리 <br>
	 * 이미 등록된 경우 삭제처리됨  <br> 
	 * 해당 스케쥴에 최대인원수를 넘을수는 없다. <br>
	 * 변경된 정보가 담긴  MoimScheduleVO 가 리턴 
	 * @param enterListVO 모임코드+스케쥴아이디+사용자아이디 
	 * @return TODO
	 * @return MoimScheduleVO 변경된 정보 조회 VO
	 */
	public MoimScheduleVO changeScheduleEnterMember( MoimScheduleVO moimScheduleVO ) throws BizMaximumExceedException ;
	
	

	/**
	 * <b>현재사용자가 해당 모임에서 참여하는 일정 목록을 리턴</b>
	 *    
	 * @param moimScheduleVO 모임코드+스케쥴아이디+사용자아이디 
	 * @return
	 * @return
	 */
	public List<MoimScheduleVO> getScheduleEnterByUser(MoimScheduleVO moimScheduleVO );
	
}
