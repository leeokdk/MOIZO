package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.ManagerNoticeSearchVO;
import com.moim.vo.ManagerNoticeVO;

/**
 * 메서드 명명규칙 이전freeBoard 참고 
 * @author ok
 * @since 2021.07.14
 */
@Mapper
public interface IManagerNoticeDao {

 public List<ManagerNoticeVO> getBoardList(ManagerNoticeSearchVO searchVO); 
 public ManagerNoticeVO getBoard(int mNoticeNo);

 public int increaseHit(int mNoticeNo);

 public int updateBoard(ManagerNoticeVO managerNoticeVO);
 public int deleteBoard(ManagerNoticeVO managerNoticeVO);
 public int insertBoard(ManagerNoticeVO managerNoticeVO);

 public int getBoardCount(ManagerNoticeSearchVO searchVO);
}
