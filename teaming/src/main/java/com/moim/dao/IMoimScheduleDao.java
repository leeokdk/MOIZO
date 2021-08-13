package com.moim.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.moim.vo.MoimScheduleSearchVO;
import com.moim.vo.MoimScheduleVO;

/**
 * 
 * 모임 일정 등록을 위한 Dao 
 * 
 * @author 다나
 * @since 2021.07.28
 */
@Mapper
public interface IMoimScheduleDao {

	public List<MoimScheduleVO> getScheduleList(MoimScheduleSearchVO searchVO);

	public MoimScheduleVO getSchedule(int mScheduleNo);

	/**
	 * 해당 모임의 스케쥴에 참여를 한다.
	 * 
	 * @param mScheduleNo 모임코드, 스케줄코드, 유저아이디 
	 * @return
	 */
	public int increaseEnter(MoimScheduleVO moimScheduleVO);
	
	/**
	 * 
	 * 해당 모임의 스케쥴에 참여를 한다.
	 * 
	 * @param mScheduleNo 모임코드, 스케줄코드, 유저아이디
	 * 
	 * @param mScheduleNo
	 * @return
	 */
	public int decreaseEnter(MoimScheduleVO moimScheduleVO);

	public int updateSchedule(MoimScheduleVO moimScheduleVO);

	public int deleteSchedule(MoimScheduleVO moimScheduleVO);

	public int insertSchedule(MoimScheduleVO moimScheduleVO);
	
	public int getScheduleCount(MoimScheduleSearchVO searchVO);
	
	/**
	 * 해당 스케쥴의 인원수를 다시 조회하여 조정한다. 
	 */
	public void  updateMoimScheduleEnterCount(MoimScheduleVO moimScheduleVO); 
	

}
