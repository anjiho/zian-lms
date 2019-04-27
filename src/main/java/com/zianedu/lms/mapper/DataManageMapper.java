package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DataManageMapper {

    /** SELECT **/
    List<TCategoryVO> selectTCategoryList(@Param("parentKey") int parentKey);

    TCategoryVO selectTCategoryInfoByCtgKey(@Param("ctgKey") int ctgKey);
    //t_category의 마지막 pos 가져오기
    int selectTCategoryLastPosNumber(@Param("parentKey") int parentKey);

    Integer selectTCategoryOtherInfoLastPosNumber(@Param("ctgKey") int ctgKey);

    List<TCategoryOtherInfoVO> selectTCategoryOtherInfoList(@Param("ctgKey") int ctgKey);

    TCategoryOtherInfoVO selectTCategoryOtherInfo(@Param("ctgInfoKey") int ctgInfoKey);

    List<TCategoryVO> selectBannerTitleList(@Param("ctgKey") int ctgKey);

    List<TCategoryVO> selectBannerTitleListByCtgKey(@Param("ctgKey") int ctgKey, @Param("roleType") int roleType);

    List<TScheduleVO> selectTScheduleList();

    TScheduleVO selectTScheduleInfo(@Param("scheduleKey") int scheduleKey);

    List<TSearchKeywordVO> selectTSearchKeywordList(@Param("className") String className);

    TSearchKeywordVO selectTSearchKeywordInfo(@Param("searchKeywordKey") int searchKeywordKey);

    int selectTSearchKeywordLastPosNumber(@Param("className") String className);

    List<TGoodTeacherLinkVO> selectTeacherList();

    List<TCategoryVO> selectTypeList(@Param("parentKey1") int parentKey1, @Param("parentKey2") int parentKey2,
                                     @Param("parentKey3") int parentKey3);

    List<TCategoryVO> selectUnitList();

    /** INSERT **/
    void insertTCategoryInfo(@Param("parentKey") int parentKey, @Param("name") String ctgName, @Param("pos") int pos);

    void insertTCategoryOtherInfo(TCategoryOtherInfoVO tCategoryOtherInfoVO);

    void insertTSchedule(TScheduleVO tScheduleVO);

    void insertTSearchKeyword(TSearchKeywordVO tSearchKeywordVO);

    /** DELETE **/
    void deleteTCategoryOtherInfo(@Param("ctgInfoKey") int ctgInfoKey);

    void deleteTSchedule(@Param("scheduleKey") int scheduleKey);

    void deleteTSearchKeyword(@Param("searchKeywordKey") int searchKeywordKey);

    void deleteTCategory(@Param("ctgKey") int ctgKey);

    /** UPDATE **/
    void updateTCategoryOtherInfo(TCategoryOtherInfoVO tCategoryOtherInfoVO);

    void changeBannerPosition(TCategoryOtherInfoVO tCategoryOtherInfoVO);

    void updateTSchedule(TScheduleVO tScheduleVO);

    void updateTSearchKeyword(@Param("searchKeywordKey") int searchKeywordKey, @Param("keyword") String keyword);
}
