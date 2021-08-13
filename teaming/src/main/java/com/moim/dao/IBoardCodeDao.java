package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.BoardTypeVO;

/**
 * 
 * <b> Board_Type <b>
 * board 코드가 담겨있는 리스트이므로 getBdCodeList라고 명명
 *
 * @author 다나
 * @since 2021.07.14
 *
 */
//@Mapper
public interface IBoardCodeDao {

	public List<BoardTypeVO> getBdCodeList();
}
