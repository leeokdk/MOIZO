package com.moim.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.moim.common.vo.ResultMessageVO;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IFreeService;
import com.moim.vo.FreeSearchVO;
import com.moim.vo.FreeVO;

@Controller
@RequestMapping("/moim")
public class FreeController {
	
	@Inject
	IFreeService freeService;
	
	
	@RequestMapping("/freeList")
	public String freeList(@ModelAttribute("searchVO") FreeSearchVO searchVO, Model model, @RequestParam("moimCode") String moimCode) {
//		model.addAttribute("searchVO",searchVO);
		searchVO.setMoimCode(moimCode);
		List<FreeVO> freeList = freeService.getFreeList(searchVO);
		model.addAttribute("freeList", freeList);
		return "free/freeList";
	}
	
	@RequestMapping("/freeView")
	public String freeView(@RequestParam(value = "freeNo", required = true)int freeNo, Model model) {
		try {
			freeService.increaseHit(freeNo);
			FreeVO free = freeService.getFree(freeNo);
			model.addAttribute("free", free);
		} catch(BizNotFoundException | BizNotEffectedException e) {
			model.addAttribute("e", e);
		}
		return "free/freeView";
	}
	
	@RequestMapping("/freeForm")
	public String freeForm(@RequestParam(value = "moimCode", required = true)String moimCode, Model model) {
		model.addAttribute("moimCode", moimCode);
		return "free/freeForm";
	}
	
	@RequestMapping(value="/freeEdit", method = RequestMethod.GET)
	public ModelAndView freeEdit(@RequestParam("freeNo")int freeNo) {
		ModelAndView mav = new ModelAndView();
		try {
			FreeVO free = freeService.getFree(freeNo);
			mav.addObject("free", free);
			mav.setViewName("free/freeEdit");
		} catch(BizNotFoundException e) {
			mav.addObject("e", e);
		}
		return mav;
	}
	
	@RequestMapping(value="/freeModify", method = RequestMethod.POST)
	public String freeModify(@ModelAttribute("free") FreeVO free, Model model) {
		try {
			freeService.modifyFree(free);
			model.addAttribute("free", free);
		} catch (BizNotFoundException|BizNotEffectedException e) {
			model.addAttribute("e", e);
		} 
		return "/free/freeModify";
	}
	
	@RequestMapping("/freeRegist")
	public String freeRegist(FreeVO free, Model model) {
		try {
			freeService.registFree(free);
			model.addAttribute("free", free);
		}catch(BizNotEffectedException e){
			model.addAttribute("e", e);
		}
		return "free/freeRegist";
	}
	
	@RequestMapping("/freeDelete")
	public String freeDelete(@ModelAttribute("free")FreeVO free, Model model) {
		try {
			freeService.removeFree(free);
			model.addAttribute("free", free);
		} catch(BizNotFoundException|BizNotEffectedException e) {
			model.addAttribute("e", e);
		}
		return "free/freeDelete";
	}

}
