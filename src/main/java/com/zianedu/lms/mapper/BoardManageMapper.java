package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.BbsCommentDTO;
import com.zianedu.lms.dto.QnaListDTO;
import com.zianedu.lms.vo.TBbsCommentVO;
import com.zianedu.lms.vo.TBbsDataVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardManageMapper {

    /** SELECT **/

    List<QnaListDTO> selectQnAList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                   @Param("teacherKey") int teacherKey, @Param("searchType") String searchType, @Param("searchText") String searchText);

    Integer selectQnAListCount(@Param("teacherKey") int teacherKey, @Param("searchType") String searchType, @Param("searchText") String searchText);

    QnaListDTO selectQnaDetailInfo(@Param("bbsKey") int bbsKey);

    List<BbsCommentDTO> selectQnaCommentList(@Param("bbsKey") int bbsKey);

    /** INSERT **/

    void insertTBbsData(TBbsDataVO tBbsDataVO);

    void insertTBbsComment(TBbsCommentVO tBbsCommentVO);

    /** UPDATE **/

    void updateTBbsData(@Param("bbsKey") int bbsKey, @Param("title") String title, @Param("contents") String contents);

    void updateTBbsComment(@Param("bbsCommentKey") int bbsCommentKey, @Param("contents") String contents);

    /** DELETE **/

    void deleteTBbsComment(@Param("bbsCommentKey") int bbsCommentKey);

}
