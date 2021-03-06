package com.moim.service;

import java.util.List;

import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.AdminNoticeSearchVO;
import com.moim.vo.AdminNoticeVO;


/**
 * freeBoardService 참고<br>
 * password매칭 예외는 추가안함
 * @author ok
 * @since 2021.07.14
 *
 */
public interface IAdminNoticeService {
	 public List<AdminNoticeVO> getBoardList(AdminNoticeSearchVO searchVO); 
	 public AdminNoticeVO getBoard(int aNoticeNo) throws BizNotFoundException;

	 public void increseHit(int aNoticeNo) throws BizNotEffectedException;

	 public void modifyBoard(AdminNoticeVO adminNoticeVO) throws BizNotFoundException, BizNotEffectedException;
	 public void removeBoard(AdminNoticeVO adminNoticeVO) throws BizNotFoundException, BizNotEffectedException;
	 public void registBoard(AdminNoticeVO adminNoticeVO) throws BizNotEffectedException;

}
