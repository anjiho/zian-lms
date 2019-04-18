package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.*;
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

    List<OfflineCouponListDTO>selectOfflineCouponList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                      @Param("couponMasterKey") int couponMasterKey);

    int selectOfflineCouponListCount(@Param("couponMasterKey") int couponMasterKey);

    List<OfflineCouponListDTO>selectOfflineCouponUserList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                      @Param("couponMasterKey") int couponMasterKey, @Param("searchText") String searchText,
                                                          @Param("searchType") String searchType);

    int selectOfflineCouponUserListCount(@Param("couponMasterKey") int couponMasterKey, @Param("searchText") String searchText,
                                         @Param("searchType") String searchType);

    int selectIssuedOfflineCouponCount(@Param("couponMasterKey") int couponMasterKey);

    List<AdminCouponListDTO>selectIssuedAdminCouponUserList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                            @Param("couponMasterKey") int couponMasterKey, @Param("searchText") String searchText,
                                                            @Param("searchType") String searchType);

    int selectIssuedAdminCouponUserListCount(@Param("couponMasterKey") int couponMasterKey, @Param("searchText") String searchText, @Param("searchType") String searchType);

    /** INSERT **/
    Integer insertTPopupInfo(TPopupVO tPopupVO);

    Integer insertTCouponMaster(TCouponMasterVO tCouponMasterVO);

    void insertTCouponIssue(TCouponIssueVO tCouponIssueVO);

    void insertTCouponOffline(TCouponOfflineVO tCouponOfflineVO);

    /** DELETE **/


    /** UPDATE **/
    void updateTPopupInfo(TPopupVO tPopupVO);

    void updateTPopupIsShow(@Param("popupKey") int popupKey, @Param("isShow") int isShow);

    void updateTCouponMaster(TCouponMasterVO tCouponMasterVO);

}
