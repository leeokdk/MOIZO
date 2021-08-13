package com.moim.web;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.groups.Default;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.moim.common.valid.ManagerNoticeValidator;
import com.moim.common.valid.Modify;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IManagerNoticeService;
import com.moim.service.IMoimService;
import com.moim.vo.ManagerNoticeVO;
import com.moim.vo.MoimVO;
/**
 * 
 * @author DNA
 * @since 2021.07.19
 */
@Controller
public class ManagerNoticeController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	IManagerNoticeService managerNoticeService;
	
	@Inject
	IMoimService moimService;

	@RequestMapping("/moimManager/moimNoticeForm")
	public String noticeForm(@ModelAttribute("ManagerNotice") ManagerNoticeVO ManagerNotice, Model model) {
		logger.debug("ManagerNoticeVO={}", ManagerNotice);

	   return "/moimManager/moimNoticeForm";
	
	}
	
	@PostMapping("/moimManager/moimNoticeRegist")
	public String NoticeRegist(@RequestParam(name = "boFiles", required = false) MultipartFile[] boFiles,
			@ModelAttribute("ManagerNotice") ManagerNoticeVO ManagerNotice, BindingResult erros, Model model
			,@ModelAttribute("moim") MoimVO moim)
			throws IOException, BizNotEffectedException {

		//벨리데이션 추가 
		new ManagerNoticeValidator().validate(ManagerNotice, erros);
		
		logger.debug("ManagerNoticeVO={}", ManagerNotice);

		if (erros.hasErrors()) { // 에러가 있으면
			return "/moimManager/moimNoticeForm";
		}
		managerNoticeService.registBoard(ManagerNotice);

	
		return "redirect:/moim/moimView?moimCode=" + moim.getMoimCode();
	}

	@RequestMapping("/moimManager/moimNoticeEdit")
	public String NoticeEdit(@RequestParam("mNoticeNo") int mNoticeNo, Model model) {

		try {
			ManagerNoticeVO moim = managerNoticeService.getBoard(mNoticeNo);
			model.addAttribute("moim", moim);
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/moimManager/moimNoticeEdit";
	}

	@PostMapping("/moimManager/moimNoticeModify")
	public String NoticeModify(
			@ModelAttribute("moim") ManagerNoticeVO moim, BindingResult erros, Model model) {

		logger.debug("ManagerNoticeVO={}", moim);
		
		//벨리데이션 추가 
		new ManagerNoticeValidator().validate(moim, erros);
		
		if (erros.hasErrors()) { // 에러가 있으면
			return "manager/moimNoticeEdit";
		}
		try {
			managerNoticeService.modifyBoard(moim);
		} catch (BizNotEffectedException | BizNotFoundException e) {
			e.printStackTrace();
		}

		return "redirect:/moimManager/moimNoticeView?mNoticeNo=" + moim.getmNoticeNo();

	}

	@RequestMapping("/moimManager/moimNoticeDelete")
	public String NoticeDelete(@ModelAttribute("ManagerNotice") ManagerNoticeVO ManagerNotice, BindingResult erros, Model model
			) throws BizNotFoundException, BizNotEffectedException{

		logger.debug("ManagerNoticeVO={}", ManagerNotice);

		if (erros.hasErrors()) { // 에러가 있으면
			return "moim/moimNoticeEdit";
		}
		try {
			managerNoticeService.removeBoard(ManagerNotice);
		} catch (BizNotEffectedException | BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:/moim/moimView?moimCode=" + ManagerNotice.getMoimCode();

	}

	@RequestMapping("/moimManager/moimNoticeView")
	public String noticeView(@RequestParam("mNoticeNo") int mNoticeNo, Model model) {

		logger.debug("mNoticeNo={}", mNoticeNo);

		try {
			// 조회수 증가
			managerNoticeService.increaseHit(mNoticeNo);
			ManagerNoticeVO moim = managerNoticeService.getBoard(mNoticeNo);
			model.addAttribute("moim", moim);
			
		


		} catch (BizNotFoundException | BizNotEffectedException e) {
			model.addAttribute("e", e);
		}

		return "moimManager/moimNoticeView";
	}

	/**
	 * 
	 * @param moimIntroduce
	 * @param model
	 * @return
	 * @throws BizNotFoundException
	 * @author DNA
	 * @since 2021.07.19
	 */

	// Tab에 사용되는 게시판 연결하기 위한 예시
	@RequestMapping("moim/moimIntroduce")
	public String IntroduceMoim(@RequestParam("moimCode") String moimCode, Model model) throws BizNotFoundException {
		MoimVO moim = moimService.getMoim(moimCode);
		model.addAttribute("moim", moim);

		return "moim/moimIntroduce";
	}



}

