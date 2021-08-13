package com.moim.service;

import java.util.List;

import com.moim.exception.BizDuplicateKeyException;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.vo.MoimMemberSearchVO;
import com.moim.vo.MoimMemberVO;
/**
 * <b> Moim_Member <b>
 * 4-4IRF IMemberService 참조
 * 
 * @author 다나
 * @since 2021.07.14
 * 
 */
public interface IMoimMemberService {
	
	public List<MoimMemberVO> getMemberList(MoimMemberSearchVO moimMemberSearchVO);
	
	public MoimMemberVO getMember(String memId) throws BizNotFoundException ;
	
	public void modifyMember(MoimMemberVO member) throws BizNotEffectedException, BizNotFoundException ;
	
	public void removeMember(MoimMemberVO member) throws BizNotEffectedException, BizNotFoundException;

	public void registMember(MoimMemberVO member) throws BizDuplicateKeyException, BizNotEffectedException;
}
