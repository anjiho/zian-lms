package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.PagingSearchDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductManageMapper {

    /** SELECT **/
    List<VideoListDTO> selectVideoList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectVideoListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    TGoodsVO selectTGoodsInfo(@Param("gKey") int gKey);

    List<TGoodsPriceOptionVO> selectTGoodsPriceOptionList(@Param("gKey") int gKey);

    List<TCategoryGoods> selectTCategoryGoodsList(@Param("gKey") int gKey);

    TLecVO selectTLecInfo(@Param("gKey") int gKey);

    List<TGoodTeacherLinkVO>selectTeacherListByTeacherLink(@Param("gKey") int gKey);

    List<TLinkKeyVO>selectTGoodsFromTLinkKeyRel(@Param("reqKey") int reqKey, @Param("resType") int resType);

    List<TLinkKeyVO>selectTExamMasterFromTLinkKeyRel(@Param("reqKey") int reqKey, @Param("resType") int resType);

    List<TLecCurri>selectTLecCurriList(@Param("lecKey") int lecKey);

    List<TLinkKeyVO>selectTLinkKeyList(@Param("reqKey") int reqKey);

    Integer selectTLecCurriLastPos(@Param("lecKey") int lecKey);

    List<TExamMasterVO>selectTExamList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTExamListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<TGoodsVO>selectTGoodsListByType(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType,
                                         @Param("goodsTypeKey") int goodsTypeKey);

    int selectTGoodsListByTypeCount(@Param("searchText") String searchText, @Param("searchType") String searchType,
                                    @Param("goodsTypeKey") int goodsTypeKey);

    /** INSERT **/
    int insertTGoods(TGoodsVO tGoodsVO);

    int insertTGoodsPriceOption(TGoodsPriceOptionVO tGoodsPriceOptionVO);

    void insertTCategoryGoods(TCategoryGoods tCategoryGoods);

    int insertTLec(TLecVO tLecVO);

    void insertTGoodsTeacherLink(TGoodTeacherLinkVO tGoodTeacherLinkVO);

    void insertTLinkKey(TLinkKeyVO tLinkKeyVO);

    Integer insertTLecCurri(TLecCurri tLecCurri);


    /** DELETE **/
    void deleteTCategoryGoods(@Param("gKey") int gKey);

    void deleteTLinkKey(@Param("reqKey") int reqKey);

    void deleteTLinkKeyByLinkKey(@Param("linkKey") int linkKey);

    void deleteTGoodsTeacherLink(@Param("gTeacherKey") int gTeacherKey);

    void deleteTLecCurri(@Param("curriKey") int curriKey);

    void deleteTCategoryGoodsByCtgGKey(@Param("ctgGKey") int ctgGKey);

    /** UPDATE **/
    void updateTGoods(TGoodsVO tGoodsVO);

    void updateTGoodsPriceOption(TGoodsPriceOptionVO tGoodsPriceOptionVO);

    void updateTLec(TLecVO tLecVO);

    void updateTGoodsTeacherLink(TGoodTeacherLinkVO tGoodTeacherLinkVO);

    void updateTLinkKey(TLinkKeyVO tLinkKeyVO);

    void updateTLecCurri(TLecCurri tLecCurri);

}
