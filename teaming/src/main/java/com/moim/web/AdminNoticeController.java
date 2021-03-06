package com.moim.web;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.validation.groups.Default;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IAdminNoticeService;
import com.moim.vo.AdminNoticeSearchVO;
import com.moim.vo.AdminNoticeVO;
import com.moim.vo.LoginVO;
import com.moim.vo.UserLikeVO;

/**
 * 
 * @author ok
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminNoticeController {
	
	@Inject
	IAdminNoticeService aNoticeService; 
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());


	@RequestMapping("/noticeList")
	public String adminNoticeList(@ModelAttribute("searchVO") AdminNoticeSearchVO searchVO, Model model) {
		logger.debug("searchVO={}", searchVO);
		model.addAttribute("searchVO", searchVO);
		List<AdminNoticeVO> aNoticeList = aNoticeService.getBoardList(searchVO);
		model.addAttribute("aNoticeList", aNoticeList);
		return "admin/noticeList";
	}

	@RequestMapping("/noticeView")
	public String adminNoticeView(@RequestParam("aNoticeNo") int aNoticeNo, Model model) {
		logger.debug("aNoticeNo={}",aNoticeNo);
		try {
			aNoticeService.increseHit(aNoticeNo);
			AdminNoticeVO aNotice = aNoticeService.getBoard(aNoticeNo);
			model.addAttribute("aNotice", aNotice);
		} catch (BizNotFoundException | BizNotEffectedException e) {
			model.addAttribute("e", e);
		}
		return "admin/noticeView";
	}

	@RequestMapping("/noticeViewForAdmin")
	public String adminNoticeView2(@RequestParam("aNoticeNo") int aNoticeNo, Model model) {
		logger.debug("aNoticeNo={}",aNoticeNo);
		try {
			aNoticeService.increseHit(aNoticeNo);
			AdminNoticeVO aNotice = aNoticeService.getBoard(aNoticeNo);
			model.addAttribute("aNotice", aNotice);
		} catch (BizNotFoundException | BizNotEffectedException e) {
			model.addAttribute("e", e);
		}
		return "admin/noticeViewForAdmin";
	}

	@RequestMapping("/noticeEdit")
	public ModelAndView adminNoticeEdit(@RequestParam("aNoticeNo") int aNoticeNo) {
		ModelAndView mav = new ModelAndView();
		try {
			AdminNoticeVO aNotice = aNoticeService.getBoard(aNoticeNo);
			mav.addObject("aNotice", aNotice);
			mav.setViewName("admin/noticeEdit");
		} catch (BizNotFoundException e) {
			mav.addObject("e", e);
		}
		return mav;
	}


	@RequestMapping("/noticeModify")
	public String adminNoticeModify(@ModelAttribute("aNotice") AdminNoticeVO aNotice,
			BindingResult errors, Model model) {
		logger.info("aNotice={}", aNotice);
		if (errors.hasErrors()) {
			return "admin/noticeEdit";
		}
		try {
			aNoticeService.modifyBoard(aNotice);
		} catch (BizNotFoundException enf) {
			model.addAttribute("enf", enf);
		} catch (BizNotEffectedException ene) {
			model.addAttribute("ene", ene);
		}
		return "admin/noticeView";
	}

	@RequestMapping("/noticeDelete")
	public String adminNoticeDelete(@ModelAttribute("aNotice") AdminNoticeVO aNotice, Model model) {
		logger.info("aNotice={}", aNotice);
		try {
			aNoticeService.removeBoard(aNotice);
		} catch (BizNotFoundException enf) { 
			model.addAttribute("enf", enf);
		} catch (BizNotEffectedException ene) { 
			model.addAttribute("ene", ene);
		}
		return "redirect:/admin/noticeList";
	}

	@RequestMapping("/noticeForm")
	public String freeForm(@ModelAttribute("aNotice") AdminNoticeVO aNotice, Model model) {
		return "admin/noticeForm";
	}

	@RequestMapping("/noticeRegist")
	public String freeRegist(@ModelAttribute("aNotice") AdminNoticeVO aNotice,
			BindingResult errors, Model model) throws IOException {
		logger.info("aNotice={}", aNotice);
		if (errors.hasErrors()) {
			return "admin/noticeForm";
		}
		try {
			aNoticeService.registBoard(aNotice);
			logger.info("aNotice={}", aNotice);
		} catch (BizNotEffectedException e) {
			model.addAttribute("e", e);
		}
		return "redirect:/admin/noticeView?aNoticeNo="+aNotice.getaNoticeNo();
	}

}
