package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TCategoryVO;
import com.zianedu.lms.vo.TScheduleVO;
import com.zianedu.lms.vo.TSearchKeywordVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DataManageMapper {

    /** SELECT **/
    List<TCategoryVO> selectTCategoryList(@Param("parentKey") int parentKey);
    //t_category의 마지막 pos 가져오기
    int selectTCategoryLastPosNumber(@Param("parentKey") int parentKey);

    int selectTCategoryOtherInfoLastPosNumber(@Param("ctgKey") int ctgKey);

    List<TCategoryOtherInfoVO> selectTCategoryOtherInfoList(@Param("ctgKey") int ctgKey);

    TCategoryOtherInfoVO selectTCategoryOtherInfo(@Param("ctgInfoKey") int ctgInfoKey);

    List<TCategoryVO> selectBannerTitleList(@Param("ctgKey") int ctgKey);

    List<TCategoryVO> selectBannerTitleListByCtgKey(@Param("ctgKey") int ctgKey, @Param("roleType") int roleType);

    List<TScheduleVO> selectTScheduleList();

    List<TSearchKeywordVO> selectTSearchKeywordList(@Param("className") String className);

    int selectTSearchKeywordLastPosNumber(@Param("className") String className);

    /** INSERT **/
    void insertClassficationTCategoryInfo(@Param("name") String ctgName, @Param("pos") int pos);

    void insertTCategoryOtherInfo(TCategoryOtherInfoVO tCategoryOtherInfoVO);

    void insertTSchedule(TScheduleVO tScheduleVO);

    void insertTSearchKeyword(TSearchKeywordVO tSearchKeywordVO);

    /** DELETE **/
    void deleteTCategoryOtherInfo(@Param("ctgInfoKey") int ctgInfoKey);

    void deleteTSchedule(@Param("scheduleKey") int scheduleKey);

    void deleteTSearchKeyword(@Param("searchKeywordKey") int searchKeywordKey);

    /** UPDATE **/
    void updateTCategoryOtherInfo(TCategoryOtherInfoVO tCategoryOtherInfoVO);

    void updateTSchedule(TScheduleVO tScheduleVO);

    void updateTSearchKeyword(@Param("searchKeywordKey") int searchKeywordKey, @Param("keyword") String keyword);
}
