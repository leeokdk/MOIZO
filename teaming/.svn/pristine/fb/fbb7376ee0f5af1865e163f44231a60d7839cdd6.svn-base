package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.AdminNoticeSearchVO;
import com.moim.vo.AdminNoticeVO;

/**
 * 메서드 명명규칙 이전freeBoard 참고 
 * @author ok
 * @since 2021.07.14
 */
@Mapper
public interface IAdminNoticeDao {
	 public List<AdminNoticeVO> getBoardList(AdminNoticeSearchVO searchVO); 
	 public AdminNoticeVO getBoard(int aNoticeNo);

	 public int increseHit(int aNoticeNo);

	 public int updateBoard(AdminNoticeVO adminNoticeVO);
	 public int deleteBoard(AdminNoticeVO adminNoticeVO);
	 public int insertBoard(AdminNoticeVO adminNoticeVO);

	 public int getBoardCount(AdminNoticeSearchVO searchVO);
}
