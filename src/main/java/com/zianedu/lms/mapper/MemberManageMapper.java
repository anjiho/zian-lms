package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.*;
import com.zianedu.lms.vo.*;
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

    TCounselVO selectTCounselInfo(@Param("counselKey") int counselKey);

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

    List<TLinkKeyVO> selectTLinkKeyByTeacher(@Param("teacherKey") int teacherKey);

    List<TLinkKeyVO> selectNumberExposureTeacherList(@Param("reqKey") int reqKey);

    List<SmsSendListDTO> selectSmsSendLogList(SmsSearchParamDTO smsSearchParamDTO);

    Integer selectSmsSendLogListCount(SmsSearchParamDTO smsSearchParamDTO);

    List<TTeacherVO> selectCalculateTeacherList();

    List<MemberListDTO> selectSearchTeacherList();

    Integer selectUserCountByUserId(@Param("userId") String userId);

    List<MemberListDTO> selectExcelDownloadUserList(@Param("searchText") String searchText, @Param("searchType") String searchType,
                                                    @Param("regStartDate") String regStartDate, @Param("regEndDate") String regEndDate,
                                                    @Param("grade") int grade, @Param("affiliationCtgKey") int affiliationCtgKey);

    List<MemberListDTO> selectExcelDownloadTeacherList(@Param("searchText") String searchText, @Param("searchType") String searchType,
                                                        @Param("regStartDate") String regStartDate, @Param("regEndDate") String regEndDate);

    /** INSERT **/
    Integer insertTUSer(TUserVO tUserVO);

    void insertTCounsel(TCounselVO tCounselVO);

    void insertTTeacher(TTeacherVO tTeacherVO);

    void insertScTran(ScTranVO scTranVO);

    /** UPDATE **/
    void updateTCounsel(TCounselVO tCounselVO);

    void updateTLinkKeyPos(@Param("linkKey") int linkKey, @Param("pos") int pos);

    void updateTUser(TUserVO tUserVO);

    void updateTTeacher(TTeacherVO tTeacherVO);

    void updateTUserSecessionObtainDate(@Param("secessionKey") int secessionKey);

    void deleteTUserSecession(@Param("secessionKey") int secessionKey);
}
