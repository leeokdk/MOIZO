package com.moim.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.moim.vo.GalleryVO;

/**
 * 메서드 명명규칙 이전freeBoard 참고<br>
 * 검색 및 페이징 기능 없음 
 * @author ok
 * @since 2021.07.14
 */
//@Mapper
public interface IGalleryDao {
	public List<GalleryVO> getBoardList();
	public GalleryVO getBoard(int galleryNo);
	public int increseHit(int galleryNo);

	public int updateBoard(GalleryVO galleryVO);
	public int deleteBoard(GalleryVO galleryVO);
	public int insertBoard(GalleryVO galleryVO);

}
