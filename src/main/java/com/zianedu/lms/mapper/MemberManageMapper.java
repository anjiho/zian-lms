package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.CounselListDTO;
import com.zianedu.lms.dto.MemberListDTO;
import com.zianedu.lms.dto.MemberSelectListDTO;
import com.zianedu.lms.dto.UserConsultListDTO;
import com.zianedu.lms.vo.TCounselVO;
import com.zianedu.lms.vo.TTeacherVO;
import com.zianedu.lms.vo.TUserSecessionVO;
import com.zianedu.lms.vo.TUserVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberManageMapper {
    /** SELECT **/
    List<MemberSelectListDTO> selectMemberListBySelect(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                       @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectMemberListBySelectCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<MemberListDTO> selectTUserList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                        @Param("searchText") String searchText, @Param("searchType") String searchType,
                                        @Param("regStartDate") String regStartDate, @Param("regEndDate") String regEndDate,
                                        @Param("grade") int grade, @Param("affiliationCtgKey") int affiliationCtgKey
    );

    int selectTUserListCount(@Param("searchText") String searchText, @Param("searchType") String searchType,
                             @Param("regStartDate") String regStartDate, @Param("regEndDate") String regEndDate,
                             @Param("grade") int grade, @Param("affiliationCtgKey") int affiliationCtgKey
    );

    List<TUserSecessionVO> selectTUserSecessionList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                    @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTUserSecessionListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<UserConsultListDTO> selectTCounselList(@Param("userKey") int userKey);

    List<TUserSecessionVO> selectTUserSecessionApplyList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                         @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTUserSecessionApplyListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    TUserVO selectTUserInfo(@Param("userKey") int userKey);

    List<CounselListDTO> selectTCounselListByPaging(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                    @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTCounselListByPagingCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<MemberListDTO> selectTeacherList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                          @Param("searchText") String searchText, @Param("searchType") String searchType,
                                          @Param("regStartDate") String regStartDate, @Param("regEndDate") String regEndDate);

    int selectTeacherListCount(@Param("searchText") String searchText, @Param("searchType") String searchType,
                             @Param("regStartDate") String regStartDate, @Param("regEndDate") String regEndDate);

    TTeacherVO selectTTeacherInfo(@Param("userKey") int userKey);


    /** INSERT **/
    Integer insertTUSer(TUserVO tUserVO);

    void insertTCounsel(TCounselVO tCounselVO);

    void insertTTeacher(@Param("userKey") int userKey);

    /** UPDATE **/
    void updateTCounsel(TCounselVO tCounselVO);
}
