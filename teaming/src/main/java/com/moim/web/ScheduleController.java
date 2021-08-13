package com.moim.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.moim.common.valid.MoimScheduleValidator;
import com.moim.exception.BizMaximumExceedException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IMoimScheduleService;
import com.moim.service.IMoimService;
import com.moim.vo.LoginVO;
import com.moim.vo.MoimScheduleVO;
import com.moim.vo.MoimVO;

/**
 * <b> 모임 일정 등록을 위한 컨트롤러 <b>
 * 
 * @author DNA
 * @since 2021.07.28
 */
@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	IMoimScheduleService moimScheduleService;

	@Inject
	IMoimService moimService;

	@RequestMapping("/scheduleForm")
	public String scheduleForm(@ModelAttribute("moimSchedule") MoimScheduleVO moimSchedule, Model model) {

		logger.debug("MoimScheduleVO={}", moimSchedule);

		return "/schedule/scheduleForm";
	}

	@RequestMapping(value="/scheduleRegist" , produces = "application/json;charset=UTF-8" )
	@ResponseBody
	public String scheduleRegist(@ModelAttribute("moimSchedule") MoimScheduleVO moimSchedule, BindingResult erros,
			Model model) throws BizNotFoundException, BizNotEffectedException, JsonProcessingException {

		logger.debug("MoimScheduleVO={}", moimSchedule);
	
		new MoimScheduleValidator().validate(moimSchedule, erros);		
		
		if (erros.hasErrors()) { // 에러가 있으면
			ObjectMapper mapper = new ObjectMapper(); 
			String json2 = ""; 
			Map<String, Object> map2 = new HashMap<String, Object>(); 
			
			for(int i=0; i< erros.getFieldErrors().size(); i++) {
				map2.put("mScheduleModDate"+i, erros.getFieldErrors().get(i).getDefaultMessage()); 
			}
			
			json2 = mapper.writeValueAsString(map2);
			System.out.println(json2);
			
			return json2;
		}
		
		moimScheduleService.registSchedule(moimSchedule);
		
		
		// 리턴타입이 json이여야 해서 간단한 json타입으로 리턴시켜줌
		return "{\"a\":\"a\"}";
		

	}

	@RequestMapping("scheduleEdit")
	public String scheduleEdit(@RequestParam("mScheduleNo") int mScheduleNo, Model model) {

		try {
			MoimScheduleVO moimSchedule = moimScheduleService.getSchedule(mScheduleNo);
			model.addAttribute("moimSchedule", moimSchedule);
		} catch (BizNotFoundException e) {
			e.printStackTrace();
		}

		return "/schedule/scheduleEdit";
	}

	@RequestMapping(value="/scheduleModify" , produces = "application/json;charset=UTF-8" )
	@ResponseBody
	public String scheduleModify(@ModelAttribute("moimSchedule") MoimScheduleVO moimSchedule, BindingResult erros,
			Model model, @ModelAttribute("moim") MoimVO moim, HttpServletRequest request) throws BizNotFoundException, BizNotEffectedException, JsonProcessingException {

		logger.debug("MoimScheduleVO={}", moimSchedule);
		
		System.out.println(request.getParameter("mScheduleNo"));
		String mScheduleNo = request.getParameter("mScheduleNo");
		new MoimScheduleValidator().validate(moimSchedule, erros);

		
		if (erros.hasErrors()) { // 에러가 있으면
			ObjectMapper mapper = new ObjectMapper(); 
			String json2 = ""; 
			Map<String, Object> map2 = new HashMap<String, Object>(); 
			
			for(int i=0; i< erros.getFieldErrors().size(); i++) {
				map2.put("mScheduleModDate"+i, erros.getFieldErrors().get(i).getDefaultMessage()); 
			}
			
			json2 = mapper.writeValueAsString(map2);
			System.out.println(json2);
			
			return json2;
		}
		
		
		moimScheduleService.modifySchedule(moimSchedule);
		
		// 리턴타입이 json이여야 해서 간단한 json타입으로 리턴시켜줌
		return "{\"a\":\"a\"}";
		
	}

	@RequestMapping(value="/scheduleDelete" , produces = "application/json;charset=UTF-8" )
	@ResponseBody
	public String scheduleDelete(@ModelAttribute("moimSchedule") MoimScheduleVO moimSchedule,
			Model model, @ModelAttribute("moim") MoimVO moim) throws BizNotFoundException, BizNotEffectedException {

		logger.debug("MoimScheduleVO={}", moimSchedule);

		try {
			moimScheduleService.removeSchedule(moimSchedule);
		} catch (BizNotEffectedException | BizNotFoundException e) {
			e.printStackTrace();
		}
		// ajax라 리턴값을 json으로 보내줘야함
		return "{\"a\":\"a\"}";
	}

	

	/**
	 * <pre>
	 * 해당 스케줄 참여를 변경하는 매핑  <br>
	 * 현재 사용자가 잠여중이라면 삭제를 진행하며 
	 * 미 참여시 참여처리를 한다. 
	 * 참여처리이후 스케줄에 총 참여자도 변된되어진다. (서비스에서)
	 * </pre>  
	 * 단, 해당 스케쥴에 최대인원수를 넘을수는 없다. 
	 * @param enterVO : 모임코드 , 스케줄번호 
	 * @return Map<String, Object> : result : 성공여부 , message : 실패했을때 메시지 
	 * @author 원장쌤
	 * @since 2021.07.28
	 */
	
	@RequestMapping(path =  "/changeScheduleEnter.ajax", produces= "application/json; charset=UTF-8" )
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
		
		try {
			MoimScheduleVO retVO = moimScheduleService.changeScheduleEnterMember(moimScheduleVO);
			retMap.put("result", true);
			retMap.put("vo", retVO);
		} catch (BizMaximumExceedException e) {
			retMap.put("result", false);
			retMap.put("message", e.getMessage());
		}
		
		return retMap;
	}

}
