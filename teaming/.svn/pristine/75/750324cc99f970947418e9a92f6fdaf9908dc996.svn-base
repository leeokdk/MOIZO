package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.MoimScheduleVO;

/**
 * 
 * 일정에 참여한 회원들을 보기만 하는 용도기 때문에 따로 insert, delete, update를 만들지 않음.
 * 
 * @author DNA
 * @since 2021.07.28
 */
@Mapper
public interface IScheduleEnterListDao {

	/**
	 * 해당 스케쥴의 참여자 목록을 조회  
	 * @param enterListVO 모임코드+스케쥴아이디
	 * @return
	 */
	public List<MoimScheduleVO> getScheduleEnterList(MoimScheduleVO moimScheduleVO );

	/**
	 * 해당 스케쥴에서 사용자 참여 제어
	 * 이미 등록된 경우 삭제    
	 * @param enterListVO  모임코드+스케쥴아이디+사용자아이디 
	 * @return
	 */
	public int mergeScheduleEnter(MoimScheduleVO moimScheduleVO );
	
	
	/**
	 * <b>현재사용자가 해당 모임에서 참여하는 일정 목록을 리턴</b>
	 *    
	 * @param moimScheduleVO 모임코드+스케쥴아이디+사용자아이디 
	 * @return
	 * @return
	 */
	public List<MoimScheduleVO> getScheduleEnterByUser(MoimScheduleVO moimScheduleVO );
	
	

}
