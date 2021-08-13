package com.moim.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.moim.exception.BizMaximumExceedException;
import com.moim.service.IMoimScheduleService;
import com.moim.service.IMoimService;
import com.moim.vo.LoginVO;
import com.moim.vo.MoimScheduleSearchVO;
import com.moim.vo.MoimScheduleVO;

/**
 * 
 * 일정 리스트는 RestController 사용해야 해서 따로 뺌
 * 
 * @author DNA
 * @since 2021.07.31
 */
@RestController
public class ScheduleListController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	
	@Inject
	IMoimScheduleService scheduleService;
	
	@Inject
	IMoimService moimService;
	
	@RequestMapping(value = "/schedule/scheduleList", produces = "application/json;charset=UTF-8" )
	public Map<String, Object> ScheduleList(MoimScheduleSearchVO searchVO) throws Exception {
		List<MoimScheduleVO> list = scheduleService.getScheduleList(searchVO);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("result", true);		// Ajax가 True라면
		map.put("data", list);			// 내용을 담음
		map.put("count", list.size());	// 글 갯수
		map.put("pagination", searchVO);
		
		logger.debug("map={}", map);
		
		return map;
	}
	
	/**
	 * <pre>
	 * 사용자가 해당 모임에 참여하는  스케줄 목록을 가져온다. <br>
	 * </pre>  
	 * @param moimScheduleVO : 모임코드 + 사용자  
	 * @return Map<String, Object> : result : 성공여부 , message : 실패했을때 메시지 
	 * @author 원장쌤
	 * @since 2021.07.28
	 */
	
	@RequestMapping(value = "/schedule/scheduleListByUser", produces = "application/json;charset=UTF-8" )
	@ResponseBody
	public Map<String, Object> userlike(HttpSession session ,  MoimScheduleVO moimScheduleVO) {		
			Map<String, LoginVO> userMap = (Map<String, LoginVO>)session.getAttribute("USER_INFO");		
			logger.debug("userMap ={}" , userMap);
			logger.debug("moimScheduleVO={}", moimScheduleVO);
			// "NOPE" 기본맵에서 사용자 정보 조회 
			LoginVO loginUser = userMap.get("NOPE");
			moimScheduleVO.setMemberId(loginUser.getUserId());
			// 해당 스케술의 남은 자리확인
			Map<String , Object> retMap = new HashMap<String, Object>();
			
			List<MoimScheduleVO> list  = scheduleService.getScheduleEnterByUser(moimScheduleVO);
			retMap.put("result", true);
			retMap.put("data", list);
			retMap.put("count", list.size());	// 글 갯수
			
			return retMap;
		}
	

		
}
