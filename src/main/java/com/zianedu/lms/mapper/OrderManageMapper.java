package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.*;
import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderManageMapper {
    /** SELECT **/
    List<OrderResultDTO> selectOrderList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                         @Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                         @Param("goodsType") int goodsType, @Param("isOffline") int isOffline,
                                         @Param("payType") int payType, @Param("isMobile") int isMobile,
                                         @Param("searchText") String searchText, @Param("searchType") String searchType, @Param("isVideoReply") int isVideoReply);

    OrderGoodsNameDTO selectGoodsNameAtLimitOne(@Param("jKey") long jKey);

    int selectOrderListCount(@Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                         @Param("goodsType") int goodsType, @Param("isOffline") int isOffline, @Param("payType") int payType,
                                         @Param("isMobile") int isMobile, @Param("searchText") String searchText,
                                         @Param("searchType") String searchType, @Param("isVideoReply") int isVideoReply);

    List<OrderResultDTO> selectCancelOrderList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                         @Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                         @Param("startCancelSearchDate") String startCancelSearchDate, @Param("endCancelSearchDate") String endCancelSearchDate,
                                         @Param("isOffline") int isOffline, @Param("payType") int payType, @Param("isMobile") int isMobile,
                                         @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectCancelOrderListCount(@Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                               @Param("startCancelSearchDate") String startCancelSearchDate, @Param("endCancelSearchDate") String endCancelSearchDate,
                                               @Param("isOffline") int isOffline, @Param("payType") int payType, @Param("isMobile") int isMobile,
                                               @Param("searchText") String searchText, @Param("searchType") String searchType);

    List<OrderLectureListDTO> selectOrderLectureVideoList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                          @Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                                          @Param("payStatus") int payStatus, @Param("orderLecStatus") int orderLecStatus,
                                                          @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectOrderLectureVideoListCount(@Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                                          @Param("payStatus") int payStatus, @Param("orderLecStatus") int orderLecStatus,
                                                          @Param("searchText") String searchText, @Param("searchType") String searchType);

    LectureTimeInfoDTO selectTOrderInfoAtLectureTime(@Param("jLecKey") int jLecKey);

    List<LectureTimeDTO> selectLectureTimeList(@Param("jLecKey") int jLecKey);

    TOrderLecCurriVO selectLectureTimeByCurriKey(@Param("jLecKey") int jLecKey, @Param("curriKey") Long curriKey);

    Long selectJGKeyByJLecKey(@Param("jLecKey") Long jLecKey);

    List<DeviceListDTO> selectPcDeviceList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                           @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectPcDeviceListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<DeviceListDTO> selectMobileDeviceList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                           @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectMobileDeviceListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    List<DeviceListDTO> selectDeviceChangeLogList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                  @Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                           @Param("deviceType") String deviceType, @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectDeviceChangeLogListCount(@Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                       @Param("searchText") String searchText, @Param("searchType") String searchType, @Param("deviceType") String deviceType);

    String selectGoodsNameByJGKey(@Param("jGKey") int jGKey);

    TDeviceLimitVO selectTDeviceLimitInfo(@Param("deviceLimitKey") int deviceLimitKey);

    List<PointListDTO> selectTPointList(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                        @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectTPointListCount(@Param("searchText") String searchText, @Param("searchType") String searchType);

    /** INSERT **/
    void insertTOrderLecCurri(TOrderLecCurriVO tOrderLecCurriVO);

    Long insertTOrder(TOrderVO tOrderVO);

    void insertTOrderGoods(TOrderGoodsVO tOrderGoodsVO);

    void insertTMemo(TMemoVO tMemoVO);

    void insertTOrderLec(TOrderLecVO tOrderLecVO);

    void insertTDeviceLimitLog(TDeviceLimitLogVO tDeviceLimitLogVO);

    void insertTPoint(TPointVO tPointVO);

    /** UPDATE **/
    void updateTOrderLecCurri(TOrderLecCurriVO tOrderLecCurriVO);

    void updateTOrderLec(@Param("jLecKey") Long jLecKey, @Param("status") int status, @Param("limitDay") int limitDay);

    void updateTOrderGoodsKind(@Param("jGKey") Long jGKey, @Param("kind") int kind);

    /** DELETE **/
    void deleteTDeviceLimit(@Param("deviceLimitKey") int deviceLimitKey);
}
