package com.moim.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.reply.vo.ReplySearchVO;
import com.moim.reply.vo.ReplyVO;
/**
 * 
 * @author DNA
 * @since 2021.07.20
 *
 */
@Mapper
public interface IReplyDao {
	public int getReplyCountByParent(ReplySearchVO searchVO);

	public List<ReplyVO> getReplyListByParent(ReplySearchVO searchVO);

	public ReplyVO getReply(int reNo);

	public int insertReply(ReplyVO reply);

	public int updateReply(ReplyVO reply);

	public int deleteReply(ReplyVO reply);
}
