package com.moim.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.moim.service.IManagerNoticeService;
import com.moim.service.IMoimService;
import com.moim.vo.ManagerNoticeSearchVO;
import com.moim.vo.ManagerNoticeVO;
/**
 * 
 * 소모임 공지게시판 리스트는 RestController 사용해야 해서 따로 뺌
 * 
 * @author DNA
 * @since 2021.07.22
 */
@RestController
public class ManagerNoticeListContoller {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	IManagerNoticeService managerNoticeService;
	
	@Inject
	IMoimService moimService;
	
	//produces = "application/json;charset=UTF-8" : Ajax에서 한글 깨짐을 해결하기 위함
	@RequestMapping(value = "moim/moimNoticeList" , produces = "application/json;charset=UTF-8" )
	public Map<String, Object> NoticeList(ManagerNoticeSearchVO searchVO) throws Exception {
		List<ManagerNoticeVO> list = managerNoticeService.getBoardList(searchVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);		// Ajax가 True라면
		map.put("data", list);			// 내용을 담음
		map.put("count", list.size());	// 글 갯수
		map.put("pagination", searchVO);
		
		logger.debug("map={}", map);
		
		return map;
	}

}
