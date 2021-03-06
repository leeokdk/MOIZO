package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.MoimMemberSearchVO;
import com.moim.vo.MoimMemberVO;

/**
 * <b> Moim_Member <b>
 * 4-4IRF IMemberDao 참조
 * 
 * @author 다나
 * @since 2021.07.14
 */
//@Mapper
public interface IMoimMemberDao {
		
		public List<MoimMemberVO> getMemberList(MoimMemberSearchVO memberSearchVO);
	
		public MoimMemberVO getMember(String memId);
	
		public int updateMember(MoimMemberVO member);
	
		public int deleteMember(MoimMemberVO member);
	
		public int insertMember(MoimMemberVO member);
		
		public String getMemRoleByUserId (String memId);

}
