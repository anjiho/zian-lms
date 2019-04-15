package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.ProblemBankListDTO;
import com.zianedu.lms.dto.ProblemBankSubjectDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PromotionManageMapper {

    /** SELECT **/
    TPromotionVO selectTPromotion(@Param("gKey") int gKey);

    List<VideoListDTO>selectPromotionProductList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                 @Param("searchText") String searchText, @Param("searchType") String searchType,
                                                 @Param("pmType") int pmType);

    int selectPromotionProductListCount(@Param("searchText") String searchText, @Param("searchType") String searchType, @Param("pmType") int pmType);

    /** INSERT **/
    void insertTPromotion(TPromotionVO tPromotionVO);


    /** DELETE **/


    /** UPDATE **/
    void updateTPromotion(TPromotionVO tPromotionVO);


}
