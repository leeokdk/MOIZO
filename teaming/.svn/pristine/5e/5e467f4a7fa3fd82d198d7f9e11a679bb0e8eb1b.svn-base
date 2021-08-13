package com.moim.service;

import java.util.List;

import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.MoimMemberSearchVO;
import com.moim.vo.MoimMemberVO;

/**
 * 
 * @author dana
 *
 */
public interface IMemeberLikeService {


	public List<MoimMemberVO> getMemberList(MoimMemberSearchVO moimMemberSearchVO);

	public void getMemberLikeCount(); 

	public void removeMember(MoimMemberVO member) throws BizNotEffectedException, BizNotFoundException;

	public void registMember(MoimMemberVO member) throws BizDuplicateKeyException, BizNotEffectedException;
}
