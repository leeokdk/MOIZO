package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.LocationVO;
import com.moim.vo.UserVO;

@Mapper
public interface ILocationDao {
	/**
	 * commCode 참고함<br>
	 * parentCode = 상위코드. (ex: 중분류 찾을땐 대분류코드, 소분류 찾을땐 중분류 코드)
	 * @param parentCode
	 * @return List
	 * @author ok
	 * @since 2021.07.14
	 */
	public List<LocationVO> getLocationByParent(String parentCode);
	
	/**
	 * 
	 * @author ok
	 * @since 2021.07.18
	 */
	public List<LocationVO> getBigLocation();
	
	/**
	 * 회원가입 시에, 하위코드까지 받아야해서 메서드 하나 더 만들었음.
	 * @author juno
	 * @since 2021.07.21
	 */
	public List<LocationVO> getLocationByParent2(String parentCode);
	
	
	/**
	 * 내정보 볼 때 지역코드 한국어로 가져오려고 사용함.
	 * @author juno
	 * @since 2021.07.28
	 */
	public LocationVO getUserLocation(UserVO user);
	
	/**
	 * 코드로 지역명 가져오기
	 * 혹시몰라 만들었다
	 * @author ok
	 */
	public String getBigName(String localBigCode);
	public String getMidName(String localMidCode);
}
