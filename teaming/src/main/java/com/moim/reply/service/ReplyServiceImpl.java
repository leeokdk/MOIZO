package com.moim.reply.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moim.exception.BizAccessFailException;
import com.moim.exception.BizNotFoundException;
import com.moim.reply.dao.IReplyDao;
import com.moim.reply.vo.ReplySearchVO;
import com.moim.reply.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements IReplyService{
	
	@Inject
	IReplyDao replyDao;

	@Override
	public List<ReplyVO> getReplyListByParent(ReplySearchVO searchVO) {
		int totalRowCount = replyDao.getReplyCountByParent(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		System.out.println("임플에서 변수넣고 떤짐"+searchVO);
		return replyDao.getReplyListByParent(searchVO);
	}

	@Override
	public void registReply(ReplyVO reply) {
		replyDao.insertReply(reply);
	}

	@Override
	public void modifyReply(ReplyVO reply) throws BizNotFoundException, BizAccessFailException {
		ReplyVO vo = replyDao.getReply(reply.getReNo());
		if (vo == null) {
			throw new BizNotFoundException("글번호[" + reply.getReNo() + "]을 조회하지 못했습니다.");
		}
		if (!vo.getReMemId().equals(reply.getReMemId())) {
			throw new BizAccessFailException("해당 글의 작성자가 아닙니다.");
		}
		replyDao.updateReply(reply);
	}

	@Override
	public void removeReply(ReplyVO reply) throws BizNotFoundException, BizAccessFailException {
		ReplyVO vo = replyDao.getReply(reply.getReNo());
		if (vo == null) {
			throw new BizNotFoundException("글번호[" + reply.getReNo() + "]을 조회하지 못했습니다.");
		}
		if (!vo.getReMemId().equals(reply.getReMemId())) {
			throw new BizAccessFailException("해당 글의 작성자가 아닙니다.");
		}
		replyDao.deleteReply(reply);
		
	}

}
