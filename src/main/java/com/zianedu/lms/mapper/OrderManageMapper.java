package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.OrderGoodsNameDTO;
import com.zianedu.lms.dto.OrderResultDTO;
import com.zianedu.lms.dto.StatisResultDTO;
import com.zianedu.lms.dto.TeacherCalculateDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderManageMapper {

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
                                         @Param("payStatus") List<String>payStatus, @Param("isOffline") int isOffline, @Param("payType") int payType, @Param("isMobile") int isMobile,
                                         @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectCancelOrderListCount(@Param("startSearchDate") String startSearchDate, @Param("endSearchDate") String endSearchDate,
                                               @Param("startCancelSearchDate") String startCancelSearchDate, @Param("endCancelSearchDate") String endCancelSearchDate,
                                               @Param("isOffline") int isOffline, @Param("payType") int payType, @Param("isMobile") int isMobile,
                                               @Param("searchText") String searchText, @Param("searchType") String searchType);
}
