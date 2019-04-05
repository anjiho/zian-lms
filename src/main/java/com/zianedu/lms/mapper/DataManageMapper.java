package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.TCategoryOtherInfoVO;
import com.zianedu.lms.vo.TCategoryVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DataManageMapper {

    List<TCategoryVO> selectTCategoryList(@Param("parentKey") int parentKey);
    //t_category의 마지막 pos 가져오기
    int selectTCategoryLastPosNumber(@Param("parentKey") int parentKey);

    List<TCategoryOtherInfoVO> selectTCategoryOtherInfoList(@Param("ctgKey") int ctgKey);

    TCategoryOtherInfoVO selectTCategoryOtherInfo(@Param("ctgInfoKey") int ctgInfoKey);

    List<TCategoryVO> selectBannerTitleList(@Param("ctgKey") int ctgKey);

    void insertClassficationTCategoryInfo(@Param("name") String ctgName, @Param("pos") int pos);

    void deleteTCategoryOtherInfo(@Param("ctgInfoKey") int ctgInfoKey);

    void updateTCategoryOtherInfo(TCategoryOtherInfoVO tCategoryOtherInfoVO);
}
