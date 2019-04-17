package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.CouponListDTO;
import com.zianedu.lms.dto.PopupListDTO;
import com.zianedu.lms.dto.VideoListDTO;
import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PopupCouponManageMapper {

    /** SELECT **/
    List<PopupListDTO>selectTPopupList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber);

    int selectTPopupListCount();

    List<TLinkKeyVO>selectTPopupLinkKey(@Param("popupKey") int popupKey);

    TPopupVO selectTPopupInfo(@Param("popupKey") int popupKey);

    List<CouponListDTO>selectTCouponMaterList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                              @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTCouponMaterListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<TLinkKeyVO>selectTCouponLinkKey(@Param("couponKey") int couponKey);

    TCouponMasterVO selectTCouponMaterInfo(@Param("couponMasterKey") int couponMasterKey);

    /** INSERT **/
    Integer insertTPopupInfo(TPopupVO tPopupVO);

    Integer insertTCouponMaster(TCouponMasterVO tCouponMasterVO);

    void insertTCouponIssue(TCouponIssueVO tCouponIssueVO);

    void insertTCouponOffline(TCouponOfflineVO tCouponOfflineVO);

    /** DELETE **/


    /** UPDATE **/
    void updateTPopupInfo(TPopupVO tPopupVO);

    void updateTPopupIsShow(@Param("popupKey") int popupKey, @Param("isShow") int isShow);

}
