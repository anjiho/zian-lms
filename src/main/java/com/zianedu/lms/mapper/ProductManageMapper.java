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

    TGoodsVO selectTGoodsInfo(@Param("gKey") int gKey);

    List<TGoodsPriceOptionVO> selectTGoodsPriceOptionList(@Param("gKey") int gKey);

    List<TCategoryGoods> selectTCategoryGoodsList(@Param("gKey") int gKey);

    TLecVO selectTLecInfo(@Param("gKey") int gKey);

    List<TGoodTeacherLinkVO>selectTeacherListByTeacherLink(@Param("gKey") int gKey);

    List<TLinkKeyVO>selectTGoodsFromTLinkKeyRel(@Param("reqKey") int reqKey, @Param("resType") int resType);

    List<TLinkKeyVO>selectTExamMasterFromTLinkKeyRel(@Param("reqKey") int reqKey, @Param("resType") int resType);

    List<TLecCurri>selectTLecCurriList(@Param("lecKey") int lecKey);

    List<TLinkKeyVO>selectTLinkKeyList(@Param("reqKey") int reqKey);

    /** INSERT **/
    int insertTGoods(TGoodsVO tGoodsVO);

    int insertTGoodsPriceOption(TGoodsPriceOptionVO tGoodsPriceOptionVO);

    /** DELETE **/


    /** UPDATE **/

}
