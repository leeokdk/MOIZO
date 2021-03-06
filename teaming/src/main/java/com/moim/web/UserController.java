package com.moim.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moim.dao.IAttentionDao;
import com.moim.dao.IHobbyDao;
import com.moim.dao.ILocationDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.ILoginService;
import com.moim.service.IMoimService;
import com.moim.service.IUserService;
import com.moim.vo.HobbyVO;
import com.moim.vo.LocationVO;
import com.moim.vo.LoginVO;
import com.moim.vo.MoimVO;
import com.moim.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
		
	@Value("#{uploadPath['file.upload.path']}")
	private String absolutePath;
	
	@Inject
	IUserService userService;
	
	@Inject
	ILoginService loginService;
	
	@Inject
	IMoimService moimService;
	
	@Inject
	ILocationDao locationDao;

	@Inject
	IHobbyDao hobbyDao;
	
	@Inject
	IAttentionDao attentionDao;
	
	@ModelAttribute("hobbyList")
	public List<HobbyVO> hobbyList() {
		List<HobbyVO> hobbyList = hobbyDao.getHobbyCode();
		return hobbyList;
	}

	@ModelAttribute("locationList")
	public List<LocationVO> locationList() {
		List<LocationVO> locationList = locationDao.getBigLocation();
		return locationList;
	}
	
	/*			????????? ??? ???????????? ????????? ????????????	 */	
	@RequestMapping("/find")
	public String findPassword(HttpServletRequest req, HttpServletResponse resp, RedirectAttributes redirectAttributes) {
		HttpSession session = req.getSession();
		session.removeAttribute("USER_INFO");
		redirectAttributes.addFlashAttribute("succesLogout", "success");
		return "redirect:/";
	}
	
	@RequestMapping("/info")
	public String getMyInfo(@RequestParam("userId") String userId, Model model) {
		try {
			UserVO user = userService.getUser(userId);
			LocationVO location = (LocationVO) locationDao.getUserLocation(user);
			model.addAttribute("userLocation", location);
			model.addAttribute("user", user);
		} catch (BizNotFoundException e) {
			e.printStackTrace();
		}
		
		return "user/info";
	}
	
	@GetMapping("/edit")
	public String userEdit(@RequestParam ("userId") String userId, Model model) {
		UserVO user = null;
		try {
			user = userService.getUser(userId);
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.debug("user={}", user);
		model.addAttribute("user", user);
		return "user/edit";
	}
	
	@PostMapping("/modify")
	public String userEdit2(@ModelAttribute("user") UserVO user, BindingResult errors,
			Model model, @RequestParam("upload_profile") MultipartFile file, RedirectAttributes redirectAttributes, HttpServletRequest req) {
		String result = "";
		logger.debug("user={}", user);
		if (errors.hasErrors()) {
			return "user/edit?userId=" + user.getUserId();
		}
		try {
			System.out.println("?????????");
			if (!user.getUserPic().equals("default")) {
				System.out.println("?????? ????????? ??????");
				String fileName = user.getUserId() + file.getOriginalFilename();
				File uploadPath = new File(absolutePath + "/userProfile", fileName);
				// ?????? ?????? ????????? ?????? ?????????
				if (!new File(absolutePath + "/userProfile").exists()) {
					new File(absolutePath + "/userProfile").mkdirs();
				}
				// ?????? ????????? ???.
				FileCopyUtils.copy(file.getBytes(), uploadPath);
				System.out.println("?????????zz");
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
				fileName = "/userProfile/" + fileName;
				user.setUserPic(fileName);		// default ?????? ?????? ?????? ??????
			}
			logger.debug("user={}", user);
			userService.modifyUser(user);
			
			LoginVO login = new LoginVO(user.getUserId(), "GUEST", user.getUserName(), user.getUserPassword(), "NOPE", user.getUserPic());
			loginService.modifyLogin(login);
			
			Map<String, LoginVO> loginMap = loginService.getUser(user.getUserId(), user.getUserPassword());
			
			
			HttpSession session = req.getSession();
			session.setAttribute("USER_INFO", loginMap);	// ????????? ???????????? ?????? : ID, ROLE, PASSWORD, name, moimcode
			session.setMaxInactiveInterval(1800);
			
			result = "????????? ?????????????????????.";
		} catch (BizNotEffectedException ene) { // update ?????? ????????? ???????????? ???????????? ?????? ???
			System.out.println("?????????3");
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
			return "redirect:/user/info?userId=" + user.getUserId();
		} catch (BizNotFoundException ef) {
			System.out.println("?????????4");
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
			return "redirect:/user/info?userId=" + user.getUserId();
		} catch (IOException e) {
			System.out.println("?????????5");
			result = "?????? ??????";
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", result);
			return "redirect:/user/info?userId=" + user.getUserId();
		}
		System.out.println("?????????6");
		redirectAttributes.addFlashAttribute("check", "y");
		redirectAttributes.addFlashAttribute("success", result);
		return "redirect:/user/info?userId=" + user.getUserId();
	}
	
	@RequestMapping("/delete")
	public String userDelete(HttpServletRequest req, RedirectAttributes redirectAttributes, @ModelAttribute("user") UserVO user) {
		String result = "";
		
		try {
			UserVO userf = userService.getUser(user.getUserId());
			userService.removeUser(userf);
			
			Map<String, LoginVO> login = loginService.getUser(userf.getUserId(), userf.getUserPassword());
			LoginVO delLogin = login.get("NOPE");
			loginService.removeLogin(delLogin);
			
			HttpSession session = req.getSession();
			session.removeAttribute("USER_INFO");
			
			Set<String> myMoimListCode = login.keySet();
            Iterator<String> iter = myMoimListCode.iterator();
            while(iter.hasNext()) {
                String moimCode = iter.next();
                if(login.get(moimCode).getRoleName().equals("MANAGER")) {
                    MoimVO moim = moimService.getMoim(moimCode);
                    moimService.removeMoim(moim);
                }
            }
			
			result = "?????? ????????? ??????????????????.";
		} catch (BizNotFoundException e1) {
			result = "?????? ?????? ??????";
			redirectAttributes.addFlashAttribute("fail", result);
			return "redirect:/";
		} catch (BizNotEffectedException e) {
			result = "?????? ?????? ??????";
			redirectAttributes.addFlashAttribute("fail", result);
			return "redirect:/";
		}
		HttpSession session = req.getSession();
		session.removeAttribute("USER_INFO");
		redirectAttributes.addFlashAttribute("success", result);
		return "redirect:/";
	}
}
