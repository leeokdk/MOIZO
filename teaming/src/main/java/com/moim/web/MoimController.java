package com.moim.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.groups.Default;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moim.common.valid.Modify;
import com.moim.dao.IHobbyDao;
import com.moim.dao.ILocationDao;
import com.moim.dao.IMoimDao;
import com.moim.dao.IMoimMapDao;
import com.moim.dao.IUserLikeDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.ILoginService;
import com.moim.service.IManagerNoticeService;
import com.moim.service.IMoimScheduleService;
import com.moim.service.IMoimService;
import com.moim.service.IUserService;
import com.moim.vo.HobbyVO;
import com.moim.vo.LocationVO;
import com.moim.vo.LoginVO;
import com.moim.vo.ManagerNoticeSearchVO;
import com.moim.vo.ManagerNoticeVO;
import com.moim.vo.MoimMapVO;
import com.moim.vo.MoimScheduleSearchVO;
import com.moim.vo.MoimScheduleVO;
import com.moim.vo.MoimSearchVO;
import com.moim.vo.MoimSearchVO_lank;
import com.moim.vo.MoimVO;
import com.moim.vo.UserLikeVO;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;


/**
 * 
 * @author ok
 * @since 2021.07.19 -> ??????(??????) 2021.07.21
 */
@Controller
public class MoimController {

	@Value("#{uploadPath['file.upload.path']}")
	private String absolutePath;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	IManagerNoticeService managerNoticeService;
	
	//?????????
	@Inject
	IMoimScheduleService moimScheduleService;
	
	@Inject
	IMoimService moimService;
	
	@Inject
	ILoginService loginService;
	
	@Inject
	IUserService userService;
	
	@Inject
	IHobbyDao hobbyDao;
	
	@Inject
	ILocationDao locationDao;
	
	@Inject
	IUserLikeDao userLikeDao;
	
	@Inject
	IMoimMapDao moimMapDao;
	
	@Inject
	IMoimDao moimDao;
	
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
	
	@RequestMapping("/")
	public String bestMoimList(@ModelAttribute("searchVO") MoimSearchVO_lank searchVO, RedirectAttributes redirectAttributes, 
			Model model, HttpServletRequest req) throws BizNotFoundException, ParseException {
		logger.debug("moimSearchVO_lank", searchVO);
		// ????????? ????????? ??????3??? ?????? ????????? ???????????? ?????? ?????? 3???.
		HttpSession session = req.getSession();
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		List<MoimScheduleVO> myMoimScheduleList = new ArrayList<MoimScheduleVO>(); 
		if(session_loginVO != null) {
			String login_userID = session_loginVO.get("NOPE").getUserId();
			UserVO login_user = userService.getUser(login_userID);
			searchVO.setSearchHobby(login_user.getUserHobby());
			
			Set<String> myMoimListCode = session_loginVO.keySet();
			Iterator<String> iter = myMoimListCode.iterator(); // set??? Iterator ?????? ??????
			List<MoimVO> myMoimList = new ArrayList<MoimVO>();
			while(iter.hasNext()) { 
				String moimCode = iter.next();
				System.out.println("iterator : " + moimCode); // iter?????? ??? ?????????
				if(!moimCode.equals("NOPE")) {
					MoimVO moim = moimService.getMoim(moimCode);
					logger.debug("moim={}", moim);
					if(moim.getManagerId().equals(session_loginVO.get("NOPE").getUserId())) {
						moim.setMoimSparemeberCount(moimDao.getSparemeberCount(moimCode));
						myMoimList.add(moim);
					}
					MoimScheduleVO moimSchedule = new MoimScheduleVO();
					moimSchedule.setMemberId(login_userID);
					moimSchedule.setMoimCode(moimCode);
					List<MoimScheduleVO> moimScheduleList = moimScheduleService.getScheduleEnterByUser(moimSchedule);
					logger.debug("moimScheduleList={}",moimScheduleList);
					if(moimScheduleList.size() > 0) {
						//???????????????
						Calendar cal = new GregorianCalendar();
						cal.add(Calendar.DATE, 1); // ?????????
						Date d = new Date(cal.getTimeInMillis()); // ???????????? date???
						String pattern = "yyyy-MM-dd";
						SimpleDateFormat sdf = new SimpleDateFormat(pattern); //???????????? ?????????
						String date = sdf.format(d);
						for(int i=0; i<moimScheduleList.size(); i++) {
							MoimScheduleVO moimSchedule_me = moimScheduleService.getSchedule(moimScheduleList.get(i).getmScheduleNo());
							logger.debug("moimSchedule_me={}",moimSchedule_me);
							logger.debug("moimSchedule",moimSchedule_me.getmScheduleModDate());
							logger.debug("date",date);
							if(moimSchedule_me.getmScheduleModDate().equals(date)) {
								myMoimScheduleList.add(moimSchedule_me);
							}
						}
					}
				}
			}
			logger.debug("moimSchedule_swal={}",myMoimScheduleList);
			model.addAttribute("moimSchedule_swal",myMoimScheduleList);
			logger.debug("myMoimList={}",myMoimList);
			model.addAttribute("myMoimList", myMoimList);
		}else {
			model.addAttribute("moimSearchVO_lank", searchVO);
		}
		List<MoimVO> moimList = moimService.getMoimListRank(searchVO);
		model.addAttribute("moimList", moimList);
		// ?????????????????? ?????? ?????? ???????????? ?????? ??????3????????? ????????? 
		int randN = (int)Math.floor(Math.random() * (18 - 1)) + 1;
		HobbyVO random_hobby = hobbyDao.getHobbyCodebyRanNum(randN);
		model.addAttribute("randHbCode",random_hobby.getHbCode());
		model.addAttribute("randHbName",random_hobby.getHbName());
		searchVO.setSearchHobby(random_hobby.getHbCode());
		List<MoimVO> moimList_pro = moimService.getMoimListRank(searchVO);
		model.addAttribute("moimList_pro", moimList_pro);
		
		
		return "home";
	}
	@RequestMapping(path =  "/moim/moimmap.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public Map<String, Object> moimMap() {
		List<MoimMapVO> moimMapList = moimMapDao.getMoimMapList();
		logger.debug("moimMapList={}", moimMapList);
		//?????????????????? ??????????????? ????????? ???????????????
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("vo", moimMapList);
		return data;
	}
	
	@RequestMapping("/moim/moimList")
	public String searchMoim(@ModelAttribute("searchVO") MoimSearchVO searchVO, Model model, HttpServletRequest req) {
		searchVO.setRowSizePerPage(9);
		logger.debug("moimSearchVO", searchVO);
		model.addAttribute("moimSearchVO", searchVO);
		List<MoimVO> moimList = moimService.getMoimList(searchVO);

		model.addAttribute("moimList", moimList);
		
		HttpSession session = req.getSession();
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		if(session_loginVO != null) {
			String session_id = session_loginVO.get("NOPE").getUserId();
			List<UserLikeVO> likeList = userLikeDao.getUserLike(session_id);
			model.addAttribute("likeList", likeList);
		}
		return "moim/moimList";
	}

	@RequestMapping("/moim/moimMake")
	public String createMoim(@ModelAttribute("moim") MoimVO moim, Model model) {
		logger.debug("moim", moim);
		return "moim/moimForm";
	}
	
	@RequestMapping("/moim/moimRegist")
	public String moimRegist(@ModelAttribute("moim") MoimVO moim, HttpServletRequest req
			,BindingResult errors , Model model, @RequestParam("upload_img") MultipartFile file
			,RedirectAttributes redirectAttributes) {
		logger.debug("moimVO={}", moim );
		if(errors.hasErrors()) {
			System.out.println("????????????");
			return "moim/moimForm";
		}
		String result = "";
		try {
			//session??? ????????? ????????? ?????? 
			HttpSession session = req.getSession();
			Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
			logger.debug("session_loginVO={}",session_loginVO);
			String session_id = session_loginVO.get("NOPE").getUserId();
			String session_name = session_loginVO.get("NOPE").getUserName();
			String session_pass = session_loginVO.get("NOPE").getUserPassword();
			String session_pic = session_loginVO.get("NOPE").getUserPic();
			
			//moim ????????? ?????????
			moim.setManagerId(session_id);
			moimService.registMoim(moim);
			
			System.out.println(file.getOriginalFilename());
			System.out.println(file.getSize());
			String fileName = "default";
			if(file.getSize() != 0) {
				//????????????
				fileName = moim.getMoimCode()+'_'+ file.getOriginalFilename();
				System.out.println(fileName);
				File uploadPath = new File(absolutePath + "/moimImage", fileName);
				// ?????? ?????? ????????? ?????? ?????????
				System.out.println(absolutePath);
				if (!new File(absolutePath + "/moimImage").exists()) {
					new File(absolutePath + "/moimImage").mkdirs();
					System.out.println(absolutePath+"/moimImage??? ??????????????????.");
				}
				// ?????? ????????? ???.
				FileCopyUtils.copy(file.getBytes(), uploadPath);
				
				// ????????? ?????? ????????????
				int permissionsCode = 777;
			    String targetPath = uploadPath.getPath(); // ??????????????? ?????? ?????? ??????????????? ??????
			    File targetFile = new File(targetPath);
			    // ??????????????? ???????????? ??????    
			    targetFile.setReadable(false, false);
			    targetFile.setWritable(false, false);
			    targetFile.setExecutable(false, false);
			    if(targetFile.exists()) {
			        if(permissionsCode == 777) {
			            // JDK 7 ??????
			            Path path = Paths.get(targetPath);
			            Set<PosixFilePermission> posixPermissions = PosixFilePermissions.fromString("rwxrwxrwx");
			            Files.setPosixFilePermissions(path, posixPermissions);
			        	}
			    	}
				
				fileName = "/moimImage/" + fileName;
			}
			moimService.updateMoimImage(moim, fileName);
			
			//login ?????????(?????????) ?????????
			LoginVO loginVO = new LoginVO(session_id, "MANAGER", session_name, session_pass, moim.getMoimCode(), session_pic);
			logger.debug("loginVO={}", loginVO );
			loginService.registUserRole(loginVO);
			
			Map<String, LoginVO> user;
			user = loginService.getUser(session_id, session_pass);
			logger.debug("user={}", user);
			session.setAttribute("USER_INFO", user);	// ????????? ???????????? ?????? : ID, ROLE, PASSWORD, name, moimcode
			session.setMaxInactiveInterval(1800);
			/*
			model.addAttribute("moimImage", fileName);
			model.addAttribute("moimCategory", hobbyDao.getHobbyName(moim.getHbCode()));
			model.addAttribute("moimLocalName", locationDao.getMidName(moim.getLocalMidCode()));
			*/
			redirectAttributes.addAttribute("moimCode",moim.getMoimCode());
		} catch (BizNotEffectedException ene) {
			result = "?????? ??????";
			model.addAttribute("check", "n");
			model.addAttribute("fail", result);
		} catch (IOException e) {
			result = "?????? ?????? ??????";
			model.addAttribute("check", "n");
			model.addAttribute("fail", result);
		} catch (BizNotFoundException e) {
			result = "?????? ?????? ??????";
			model.addAttribute("check", "n");
			model.addAttribute("fail", result);
		}
		return "redirect:/moim/moimView";
	}
	
	/**
	 * ????????? ?????? ?????????(??????)????????? json?????? ?????? 
	 * @param moim
	 * @author ok
	 * @since 2021.07.20
	 */
	@RequestMapping(path =  "/moim/locationDetail.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public List<LocationVO> locationDetail(String bigCode) {
		logger.debug("bigCode={}", bigCode);
		List<LocationVO> result =  locationDao.getLocationByParent(bigCode);
		return result;
	}
	
	@RequestMapping(path =  "/moim/locationDetail2.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public List<LocationVO> locationDetail2(String midCode) {
		logger.debug("midCode={}", midCode);
		List<LocationVO> result =  locationDao.getLocationByParent2(midCode);
		return result;
	}
	
	
	/**
	 * ????????? ??????
	 * @author ok
	 * @since 2021.07.28
	 */
	@SuppressWarnings("null")
	@RequestMapping(path =  "/moim/userlike.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public String userlike(HttpServletRequest req, String moimCode, UserLikeVO likeVO) {
		HttpSession session = req.getSession();
		Map<String, LoginVO> lobj_getData = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		System.out.println(lobj_getData);
		String ls_getdata = lobj_getData.get("NOPE").getUserId();
		System.out.println(ls_getdata);
		//UserLikeVO??? ??????
		
		likeVO.setMoimCode(moimCode);
		likeVO.setUserId(ls_getdata);
		logger.debug("userLikeVO={}", likeVO);
		int result = userLikeDao.searchUserLike(likeVO);
		if(result==1) {
			userLikeDao.deleteUserLike(likeVO);
			return "???????????? ??????????????????";
		}else {
			userLikeDao.insertUserLike(likeVO);
			return "???????????? ???????????????";
		}
	}
	
	@RequestMapping("/moim/moimEdit")
	public ModelAndView moimEdit(@RequestParam("moimCode") String moimCode) {
		ModelAndView mav = new ModelAndView();
		String result = "";
		try {
			MoimVO moim =  moimService.getMoim(moimCode);
			mav.addObject("moim", moim);
			mav.setViewName("moim/moimEdit");
		} catch (BizNotFoundException e) {
			result = "?????? ????????? ?????? ???????????????.";
			mav.addObject("check", "n");
			mav.addObject("fail", result);
			
		}
		return mav;
	}
	
	@RequestMapping("/moim/moimModify")
	public String modifyMoim(@ModelAttribute("moim")@Validated({ Default.class, Modify.class }) MoimVO moim
			,BindingResult errors , Model model, RedirectAttributes redirectAttributes
			, @RequestParam("upload_img") MultipartFile file) {
		logger.debug("moimVO={}", moim );
		if(errors.hasErrors()) {
			return "moim/moimEdit";
		}
		String result = "";
		try {
			moimService.modifyMoim(moim);
			String fileName = moim.getMoimImage();
			if(file.getSize() != 0) {
				//????????????
				fileName = moim.getMoimCode()+'_'+ file.getOriginalFilename();
				System.out.println(fileName);
				File uploadPath = new File(absolutePath + "/moimImage", fileName);
				// ?????????????????? ????????? ??????????????? ???????????? ??????
				if (!new File(absolutePath + "/moimImage" + fileName).exists()) {
					// ?????? ?????? ????????? ?????? ?????????
					System.out.println(absolutePath);
					if (!new File(absolutePath + "/moimImage").exists()) {
						new File(absolutePath + "/moimImage").mkdirs();
						System.out.println(absolutePath+"/moimImage??? ??????????????????.");
					}
					// ?????? ????????? ???.
					FileCopyUtils.copy(file.getBytes(), uploadPath);
					// ????????? ?????? ????????????
					int permissionsCode = 777;
					String targetPath = uploadPath.getPath(); // ??????????????? ?????? ?????? ??????????????? ??????
					File targetFile = new File(targetPath);
					// ??????????????? ???????????? ??????    
					targetFile.setReadable(false, false);
					targetFile.setWritable(false, false);
					targetFile.setExecutable(false, false);
					if(targetFile.exists()) {
						if(permissionsCode == 777) {
							// JDK 7 ??????
							Path path = Paths.get(targetPath);
							Set<PosixFilePermission> posixPermissions = PosixFilePermissions.fromString("rwxrwxrwx");
							Files.setPosixFilePermissions(path, posixPermissions);
						}
					}
				}
				fileName = "/moimImage/" + fileName;
			}
			moimService.updateMoimImage(moim, fileName);
		} catch (BizNotEffectedException ene) {
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
		} catch (BizNotFoundException enf) {
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
		} catch (IOException e) {
			result = "?????? ?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
			// ??????????????? ?????? io exception ??? ????????? ????????? try-catch ?????? ????????????
		}
		
		result = "?????? ??????";
		redirectAttributes.addFlashAttribute("check", "y");
		redirectAttributes.addFlashAttribute("success", result);
		redirectAttributes.addAttribute("moimCode", moim.getMoimCode());
		return "redirect:/moim/moimEdit";
	}
	
	@RequestMapping("/moim/moimDelete")
	public String removeMoim(@ModelAttribute("moim") MoimVO moim
			, Model model, RedirectAttributes redirectAttributes
			, HttpServletRequest req) {
		logger.debug("moimVO={}", moim );
		HttpSession session = req.getSession();
		Map<String, LoginVO> userInfoMap = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		logger.debug("userInfoMap={}", userInfoMap);
		LoginVO userInfo = userInfoMap.get("NOPE");
		//LoginVO deleteUser = userInfoMap.get(moim.getMoimCode());
		logger.debug("userInfo={}", userInfo);
		Map<String, LoginVO> user;
		String result = "";
		try {
			moimService.removeMoim(moim);
			session.removeAttribute("USER_INFO");
			user = loginService.getUser(userInfo.getUserId(), userInfo.getUserPassword());
			logger.debug("user={}", user);
			session.setAttribute("USER_INFO", user);	// ????????? ???????????? ?????? : ID, ROLE, PASSWORD, name, moimcode
			session.setMaxInactiveInterval(1800);
		} catch (BizNotEffectedException ene) {
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
		} catch (BizNotFoundException enf) {
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
		}
		result = "?????? ??????";
		redirectAttributes.addFlashAttribute("check", "y");
		redirectAttributes.addFlashAttribute("success", result);
		return "redirect:/moim/moimUser";
	}

	/**
	 * 
	 * ????????? ?????? ?????????????????? ????????? ?????? ?????? ??????
	 * 
	 * @author DNA
	 * @since 2021.07.21
	 */
	@RequestMapping("moim/moimView")
	public String moimView(@ModelAttribute("searchVO") ManagerNoticeSearchVO searchVO,
			@ModelAttribute("scheduleSearchVO") MoimScheduleSearchVO scheduleSearchVO,
			@RequestParam("moimCode") String moimCode, Model model, HttpServletRequest request
			, HttpSession session) {
		logger.debug("moimCode={}", moimCode);
		Map<String, LoginVO> user_session = (Map<String, LoginVO>) session.getAttribute("USER_INFO");
		String userId = user_session.get("NOPE").getUserId();
		String userPassword = user_session.get("NOPE").getUserPassword();
		session.removeAttribute("USER_INFO");
		Map<String, LoginVO> user;
		try {
			user = loginService.getUser(userId, userPassword);
			session.setAttribute("USER_INFO", user);    // ????????? ???????????? ?????? : ID, ROLE, PASSWORD, name, moimcode
			session.setMaxInactiveInterval(1800);
		} catch (BizNotFoundException e1) {
			e1.printStackTrace();
		}
		
		String result = "";
		try {
			MoimVO moim = moimService.getMoim(moimCode);
			model.addAttribute("moim", moim);
			// MoimVO??? DB?????? ????????? Model??? ??????
			
			//????????? ????????? ????????? ?????? 
			List<MoimScheduleVO> scheduleVO = moimScheduleService.getScheduleList(scheduleSearchVO);
			model.addAttribute("scheduleVO", scheduleVO);
			
			// List<ManagerNoticeVO> ??? DB?????? ????????? Model??? ??????
			List<ManagerNoticeVO> managerNoticeList = managerNoticeService.getBoardList(searchVO);
			model.addAttribute("managerNoticeList", managerNoticeList);
			
			// ??????????????? ?????? ?????????
			model.addAttribute("moimCode", moimCode);

		} catch (BizNotFoundException e) {
			result = "??????????????? ????????????.";
			model.addAttribute("check", "n");
			model.addAttribute("fail", result);
		}
		return "moim/moimView";
	}
	
	/**
	 * ????????? ???????????? ?????? ?????????
	 * @author ok
	 */
	@RequestMapping(path =  "/moim/joinMoim.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public String joinMoim(@RequestBody Map<String,String> map, HttpServletRequest req) {
		logger.debug("map={}", map);
		String join_roleName = map.get("roleName");
		String join_moimCode = map.get("moimCode");		
		
		String result = "";
		
		HttpSession session = req.getSession();
		Map<String, LoginVO> userInfoMap = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		logger.debug("userInfoMap={}", userInfoMap);
		LoginVO userInfo = userInfoMap.get("NOPE");
		
		userInfo.setRoleName(join_roleName);
		userInfo.setMoimCode(join_moimCode);
		
		logger.debug("userInfo={}", userInfo);
		Map<String, LoginVO> user;
		try {
				loginService.registUserRole(userInfo);
				user = loginService.getUser(userInfo.getUserId(), userInfo.getUserPassword());
				logger.debug("user={}", user);
				session.setAttribute("USER_INFO", user);	// ????????? ???????????? ?????? : ID, ROLE, PASSWORD, name, moimcode
				session.setMaxInactiveInterval(1800);
			result = "?????? ????????? ?????????????????????.";
		} catch (BizNotEffectedException e) {
			result = "?????? ????????? ??????????????????.";
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			result = "?????? ????????? ??????????????????.";
		} 
		return result;
	}
	
	/**
	 * ????????? ???????????? ?????? ?????????
	 * @author ok
	 */
	@RequestMapping(path =  "/moim/outMoim.ajax", produces= "application/json; charset=UTF-8")
	@ResponseBody
	public String outMoim(String moimCode, HttpServletRequest req) {
		logger.debug("moimCode={}", moimCode);	
		
		String result = "";
		HttpSession session = req.getSession();
		Map<String, LoginVO> userInfoMap = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		logger.debug("userInfoMap={}", userInfoMap);
		LoginVO userInfo = userInfoMap.get(moimCode);
		logger.debug("userInfo={}", userInfo);
		
		try {
				loginService.removeRole(userInfo);
				Map<String, LoginVO> user = loginService.getUser(userInfo.getUserId(), userInfo.getUserPassword());
				session.setAttribute("USER_INFO", user);	// ????????? ???????????? ?????? : ID, ROLE, PASSWORD, name, moimcode
				session.setMaxInactiveInterval(1800);
				logger.debug("user={}",user);
			result = "?????? ????????? ?????????????????????.";
		} catch (BizNotEffectedException e) {
			result = "?????? ????????? ??????????????????.";
		} catch (BizNotFoundException e) {
			result = "?????? ????????? ??????????????????.";
		} 
		return result;
	}
	
	/**
	 * ?????? ?????? ??????
	 * @author juno
	 */
	@RequestMapping(path =  "/moim/joinMoimForManager.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public String joinMoimForManager(@RequestBody Map<String,String> map, HttpServletRequest req) {
		logger.debug("map={}", map);
		String userId = map.get("userId");
		String moimCode = map.get("moimCode");		
		
		String result = "";
		
		try {
				UserVO user = userService.getUser(userId);
				Map<String, LoginVO> loginMap = loginService.getUser(user.getUserId(), user.getUserPassword());
				logger.debug("loginMap={}", loginMap);
				LoginVO login = loginMap.get(moimCode);
				
				login.setRoleName("MEMBER");
				
				logger.debug("login={}", login);
				loginService.modify(login);
				result = "TRUE";
		} catch (BizNotEffectedException e) {
			result = "FALSE";
		} catch (BizNotFoundException e) {
			result = "FALSE";
		} 
		return result;
	}
	/**
	 * ?????? ?????? ??????
	 * @author juno
	 */
	@RequestMapping(path =  "/moim/outMoimForManager.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public String outMoimForManager(@RequestBody Map<String,String> map, HttpServletRequest req) {
		logger.debug("map={}", map);
		String userId = map.get("userId");
		String moimCode = map.get("moimCode");		
		
		String result = "";
		
		try {
				UserVO user = userService.getUser(userId);
				Map<String, LoginVO> loginMap = loginService.getUser(user.getUserId(), user.getUserPassword());
				logger.debug("loginMap={}", loginMap);
				LoginVO login = loginMap.get(moimCode);
				
				logger.debug("login={}", login);
				loginService.removeRole(login);
				result = "TRUE";
		} catch (BizNotEffectedException e) {
			result = "FALSE";
		} catch (BizNotFoundException e) {
			result = "FALSE";
		} 
		return result;
	}
	
	// ?????? ?????? ????????????
	
	@RequestMapping("/moim/moimMemberList")
	public String moimMember(@ModelAttribute("searchVO") UserSearchVO searchVO, HttpServletRequest req,
			@RequestParam("moimCode") String moimCode, Model model) {
		HttpSession session = req.getSession();
		logger.debug("moimCode={}", moimCode);
		searchVO.setMoimCode(moimCode);
		model.addAttribute("searchVO", searchVO);
		logger.debug("searchVO={}", searchVO);
		
		Map<String, LoginVO> userInfoMap = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		logger.debug("userInfoMap={}", userInfoMap);
		LoginVO userInfo = userInfoMap.get(moimCode);
		
		model.addAttribute("managerCheck", userInfo);
		return "moim/moimMemberList";
	}
	
	@RequestMapping(value = "/moim/moimMemberList.ajax" , produces = "application/json;charset=UTF-8" )
	@ResponseBody
	public Map<String, Object> moimMemberList(UserSearchVO searchVO) {
		if(searchVO.getLastRow() == 0) {
			searchVO.setFirstRow(0);
		}
		List<UserVO> memberList;
		try {
			memberList = moimService.getMemberList(searchVO.getMoimCode(), "MEMBER", searchVO);
			logger.debug("memberList={}", memberList);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("result", true);		// Ajax??? True??????
			map.put("data", memberList);			// ????????? ??????
			map.put("count", memberList.size());	// ??? ??????
			map.put("pagination", searchVO);
			
			logger.debug("map={}", map);
			
			return map;
		} catch (BizNotFoundException e) {
			return null;
		}
		
	}
	
	@RequestMapping(value = "/moim/moimSpareMemberList.ajax" , produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public Map<String, Object> moimSpareMemberList(UserSearchVO searchVO)  {
		System.out.println(searchVO.getMoimCode());
		if(searchVO.getLastRow() == 0) {
			searchVO.setFirstRow(0);
		}
		List<UserVO> spareMemberList;
		try {
			spareMemberList = moimService.getMemberList(searchVO.getMoimCode(), "SPAREMEMBER", searchVO);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("result", true);		// Ajax??? True??????
			map.put("data", spareMemberList);			// ????????? ??????
			map.put("count", spareMemberList.size());	// ??? ??????
			map.put("pagination", searchVO);
			
			logger.debug("map={}", map);
			
			return map;
		} catch (BizNotFoundException e) {
			return null;
		}
	}
	
	/**
	 * ????????? ????????? ?????? ???????????? 
	 * @author ok
	 * @since 0810
	 */
	@RequestMapping(path =  "/moim/managerInfo.ajax", produces= "application/json; charset=UTF-8")
	@ResponseBody
	public UserVO managerInfo(String moimCode) {
		logger.debug("moimCode={}", moimCode);	
		MoimVO moim;
		try {
			moim = moimService.getMoim(moimCode);
			logger.debug("moim={}", moim);
			String manager_id = moim.getManagerId();
			UserVO manager = userService.getUser(manager_id);
			logger.debug("manager={}", manager);
			return manager;
		} catch (BizNotFoundException e) {
			e.printStackTrace();
			return null;
		}
	}
}
