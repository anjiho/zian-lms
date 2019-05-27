package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.BbsCommentDTO;
import com.zianedu.lms.dto.QnaListDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardManageMapper {

    List<QnaListDTO> selectQnAList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                   @Param("searchType") String searchType, @Param("searchText") String searchText);

    Integer selectQnAListCount(@Param("searchType") String searchType, @Param("searchText") String searchText);

    QnaListDTO selectQnaDetailInfo(@Param("bbsKey") int bbsKey);

    List<BbsCommentDTO> selectQnaCommentList(@Param("bbsKey") int bbsKey);
}
