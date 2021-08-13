package com.moim.reply.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.moim.reply.service.IReplyService;
import com.moim.reply.vo.ReplySearchVO;
import com.moim.reply.vo.ReplyVO;
import com.moim.exception.BizAccessFailException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.LoginVO;
import com.moim.vo.MoimMemberVO;
/**
 * 
 * 
 * @author DNA
 * @since 2021.07.20
 *
 */
@RestController		//Controller + ResponseBody
public class ReplyController {
	
	@Inject
	IReplyService replyService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	

	@RequestMapping(value = "/reply/replyList", produces = "application/json;charset=UTF-8")
	public Map<String, Object> replyList(ReplySearchVO searchVO, @RequestParam("reCode") String reCode) throws Exception {
		System.out.println(searchVO);
		searchVO.setReCode(reCode);
		System.out.println(searchVO);
		List<ReplyVO> list = replyService.getReplyListByParent(searchVO);
		logger.debug("list={}",list);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);			// AJAX true
		map.put("data", list);				// 댓글 내용
		map.put("count", list.size());		// 댓글 갯수
		
		logger.debug("map = {}", map);
		
		return map;
	}

	// @PostMapping ("/reply/replyRegist")
	@RequestMapping(value = "/reply/replyRegist", method = RequestMethod.POST)
	public Map<String, Object> replyRegist(ReplyVO reply, HttpServletRequest req, HttpSession session)
			throws Exception {
		session = req.getSession();
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		reply.setReMemId(session_loginVO.get("NOPE").getUserId());	 
	   reply.setReMemName(session_loginVO.get("NOPE").getUserName()); // 이름도 받아오기
		replyService.registReply(reply);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);	
		map.put("msg", "정상 등록 되었습니다.");
		return map;
	}

	@RequestMapping(value = "/reply/replyModify")
	public Map<String, Object> replyModify(ReplyVO reply, HttpSession session) throws Exception {
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		reply.setReMemId(session_loginVO.get("NOPE").getUserId());	 
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			replyService.modifyReply(reply);
			map.put("result", true);
			map.put("msg", "수정 되었습니다.");
			return map;
		} catch (BizNotFoundException e) {
			map.put("result", false);
			map.put("msg", "글이 존재하지 않습니다.");
			return map;
		} catch (BizAccessFailException e) {
			map.put("result", false);
			map.put("msg", "접근에 실패했습니다.");
			return map;
		}
	}
	
	//Delete
	@RequestMapping(value = "/reply/replyDelete")
	public Map<String, Object> replyDelete(ReplyVO reply, HttpSession session) throws Exception {
		Map<String, LoginVO> session_loginVO = (Map<String, LoginVO>)session.getAttribute("USER_INFO");
		reply.setReMemId(session_loginVO.get("NOPE").getUserId());	 
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			replyService.removeReply(reply);
			map.put("result", true);
			map.put("msg", "삭제 되었습니다.");
			return map;
		} catch (BizNotFoundException e) {
			map.put("result", false);
			map.put("msg", "글이 존재하지 않습니다.");
			return map;
		} catch (BizAccessFailException e) {
			map.put("result", false);
			map.put("msg", "접근에 실패했습니다.");
			return map;
		}
	}

}
