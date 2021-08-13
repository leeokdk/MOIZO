package com.moim.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moim.dao.IHobbyDao;
import com.moim.dao.ILocationDao;
import com.moim.dao.IUserLikeDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IAdminNoticeService;
import com.moim.service.IMoimService;
import com.moim.service.IUserService;
import com.moim.vo.AdminNoticeSearchVO;
import com.moim.vo.AdminNoticeVO;
import com.moim.vo.HobbyVO;
import com.moim.vo.LocationVO;
import com.moim.vo.LoginVO;
import com.moim.vo.MoimSearchVO;
import com.moim.vo.MoimVO;
import com.moim.vo.UserLikeVO;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;

/**
 * 
 * @author ok
 *
 */
@Controller
@RequestMapping("/moim")
public class MyMoimController {
	
	@Inject
	IAdminNoticeService aNoticeService;
	
	@Inject
	IMoimService moimService;
	
	@Inject
	IUserService userService;
	
	@Inject
	IHobbyDao hobbyDao;
	
	@Inject
	ILocationDao locationDao;
	
	@Inject
	IUserLikeDao userLikeDao;
	
	@ModelAttribute("hobbyList")
	public List<HobbyVO> hobbyList(){
		List<HobbyVO> hobbyList = hobbyDao.getHobbyCode();
		return hobbyList;
	}
	@ModelAttribute("locationList")
	public List<LocationVO> locationList(){
		List<LocationVO> locationList = locationDao.getBigLocation();
		return locationList;
	}
	
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/*			관리자 페이지 통합			 */
	@RequestMapping("/moimUser")
	public String moimUserMain() {
		return "moim/moimUser";
	}

	
	/*			속 모임 관리			 */
	// 1. 가입한 모임 보여주기 
	@SuppressWarnings("null")
	@RequestMapping("/joinMoimList")
	public String joinMoimList(@ModelAttribute("searchVO") MoimSearchVO searchVO
			, Model model, HttpServletRequest req) throws BizNotFoundException {
		//searchVO.setRowSizePerPage(4);
		HttpSession session = req.getSession();
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		Set<String> myMoimListCode = session_loginVO.keySet();
		Iterator<String> iter = myMoimListCode.iterator(); // set을 Iterator 안에 담기
		List<MoimVO> myMoimList = new ArrayList<MoimVO>();
		List<MoimVO> myMoimList_M = new ArrayList<MoimVO>();
		while(iter.hasNext()) { 
			String moimCode = iter.next();
			System.out.println("iterator : " + moimCode); // iter에서 값 꺼내기
			if(!moimCode.equals("NOPE")) {
				MoimVO moim = moimService.getMoim(moimCode);
				logger.debug("moim={}", moim);
				if(!moim.getManagerId().equals(session_loginVO.get("NOPE").getUserId())) {
					if(session_loginVO.get(moimCode).getRoleName().equals("SPAREMEMBER")) {
						System.out.println(moimCode + " SPAREMEM");
					}else {
						System.out.println("managerId : " + moim.getManagerId()); 
						System.out.println("myId : " + session_loginVO.get("NOPE").getUserId()); 
						myMoimList.add(moim);
					}
				}else {
					System.out.println("managerId : " + moim.getManagerId()); 
					System.out.println("myId : " + session_loginVO.get("NOPE").getUserId()); 
					myMoimList_M.add(moim);
				}
			};
		};
		logger.debug("myMoimList={}", myMoimList);
		model.addAttribute("myMoimList", myMoimList);
		logger.debug("myMoimList_M={}", myMoimList_M);
		model.addAttribute("myMoimList_M", myMoimList_M);
		return "moim/joinMoimList";
	}	
	
	// 2. 좋아요 누른 모임/가입신청한 모임 보여주기 
	@RequestMapping("/likeMoimList")
	public String likeMoimList(@ModelAttribute("searchVO") MoimSearchVO searchVO
			, Model model, HttpServletRequest req) throws BizNotFoundException {
		HttpSession session = req.getSession();
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		Set<String> myMoimListCode = session_loginVO.keySet();
		Iterator<String> iter = myMoimListCode.iterator(); // set을 Iterator 안에 담기
		List<MoimVO> myMoimList = new ArrayList<MoimVO>();
		while(iter.hasNext()) { 
			String moimCode = iter.next();
			System.out.println("iterator : " + moimCode); // iter에서 값 꺼내기
			if(!moimCode.equals("NOPE")) {
				MoimVO moim = moimService.getMoim(moimCode);
				logger.debug("moim={}", moim);
				if(session_loginVO.get(moimCode).getRoleName().equals("SPAREMEMBER")) {
					myMoimList.add(moim);
				}
			}
		}
		logger.debug("myMoimList={}",myMoimList);
		model.addAttribute("myMoimList", myMoimList);
		String userId = session_loginVO.get("NOPE").getUserId();
		List<UserLikeVO> userLikeList = userLikeDao.getUserLike(userId);
		logger.debug("userLikeList={}", userLikeList);
		List<MoimVO> myLikeMoimList = new ArrayList<MoimVO>();
		for(int i=0; i<userLikeList.size(); i++) {
			String moimCode = userLikeList.get(i).getMoimCode();
			myLikeMoimList.add(moimService.getMoim(moimCode));
		}
		logger.debug("myLikeMoimList={}", myLikeMoimList);
		model.addAttribute("myLikeMoimList", myLikeMoimList);
		return "moim/likeMoimList";
	}	


}
