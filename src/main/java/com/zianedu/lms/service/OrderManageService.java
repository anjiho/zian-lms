package com.zianedu.lms.service;


import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.define.datasource.OrderPayStatusType;
import com.zianedu.lms.define.datasource.OrderPayType;
import com.zianedu.lms.dto.OrderGoodsNameDTO;
import com.zianedu.lms.dto.OrderResultDTO;
import com.zianedu.lms.mapper.OrderManageMapper;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

@Service
public class OrderManageService {

    final static Logger logger = LoggerFactory.getLogger(OrderManageService.class);

    @Autowired
    private OrderManageMapper orderManageMapper;

    /**
     * 주문목록 조회
     * @param sPage
     * @param listLimit
     * @param startSearchDate 검색일 시작
     * @param endSearchDate 검색일 종료
     * @param goodsType 상품타입 GoodsType 정의
     * @param isOffline 구매장소 (0,1), 전체 : -1
     * @param payType 결제방법 {@link OrderPayType}, 전체 : -1
     * @param isMobile 디바이스 (0 : PC, 1: Mobile), 전체 : -1
     * @param searchType 검색 타입
     * @param searchText 검색명
     * @param isVideoReply 동영상주문(재수강 여부) 1 : 재수강 , 나머지 상품은 0
     * @return
     */
    @Transactional(readOnly = true)
    public List<OrderResultDTO> getOrderList(int sPage, int listLimit, String startSearchDate, String endSearchDate, String goodsType,
                                             int isOffline, int payType, int isMobile, String searchType, String searchText,
                                             int isVideoReply) {
        if (sPage == 0 && "".equals(startSearchDate) && "".equals(endSearchDate)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);


        List<OrderResultDTO>list = orderManageMapper.selectOrderList(
                startNumber, listLimit, Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                GoodsType.getGoodsTypeKey(goodsType), isOffline, payType, isMobile,
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""), isVideoReply
        );

        if (list != null && list.size() > 0) {
            for (OrderResultDTO orderResultDTO : list) {
                OrderGoodsNameDTO goodsNameDTO = orderManageMapper.selectGoodsNameAtLimitOne(orderResultDTO.getJKey());
                if (goodsNameDTO != null) {
                    orderResultDTO.setOrderGoodsName(goodsNameDTO.getGName());
                    orderResultDTO.setOrderGoodsCount(goodsNameDTO.getCnt());
                    orderResultDTO.setPayTypeName(OrderPayType.getOrderPayTypeStr(orderResultDTO.getPayType()));
                    orderResultDTO.setPayStatusName(OrderPayStatusType.getOrderPayStatusStr(orderResultDTO.getPayStatus()));
                }
            }
        }
        return list;
    }

    /**
     * 주문목록 조회 개수
     * @param startSearchDate
     * @param endSearchDate
     * @param goodsType
     * @param isOffline
     * @param payType
     * @param isMobile
     * @param searchType
     * @param searchText
     * @param isVideoReply
     * @return
     */
    @Transactional(readOnly = true)
    public int getOrderListCount(String startSearchDate, String endSearchDate, String goodsType, int isOffline,
                            int payType, int isMobile, String searchType, String searchText, int isVideoReply) {

        return orderManageMapper.selectOrderListCount(
                Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                GoodsType.getGoodsTypeKey(goodsType), isOffline, payType, isMobile,
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""), isVideoReply
        );
    }

    /**
     * 취소 주문목록 리스트
     * @param sPage
     * @param listLimit
     * @param startSearchDate
     * @param endSearchDate
     * @param startCancelSearchDate
     * @param endCancelSearchDate
     * @param isOffline
     * @param payType
     * @param isMobile
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<OrderResultDTO> getCancelOrderList(int sPage, int listLimit, String startSearchDate, String endSearchDate,
                                                   String startCancelSearchDate, String endCancelSearchDate, int isOffline,
                                                   int payType, int isMobile, String searchType, String searchText) {
        if (sPage == 0 && "".equals(startSearchDate) && "".equals(endSearchDate)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<String>payStatus = Arrays.asList("8", "9", "10");

        List<OrderResultDTO>list = orderManageMapper.selectCancelOrderList(
                startNumber, listLimit, Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                Util.isNullValue(startCancelSearchDate, ""), Util.isNullValue(endCancelSearchDate, ""),
                payStatus, isOffline, payType, isMobile, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );

        if (list != null && list.size() > 0) {
            for (OrderResultDTO orderResultDTO : list) {
                OrderGoodsNameDTO goodsNameDTO = orderManageMapper.selectGoodsNameAtLimitOne(orderResultDTO.getJKey());
                if (goodsNameDTO != null) {
                    orderResultDTO.setOrderGoodsName(goodsNameDTO.getGName());
                    orderResultDTO.setOrderGoodsCount(goodsNameDTO.getCnt());
                    orderResultDTO.setPayTypeName(OrderPayType.getOrderPayTypeStr(orderResultDTO.getPayType()));
                    orderResultDTO.setPayStatusName(OrderPayStatusType.getOrderPayStatusStr(orderResultDTO.getPayStatus()));
                }
            }
        }
        return list;
    }

    /**
     * 취소주문 리스트 개수
     * @param startSearchDate
     * @param endSearchDate
     * @param startCancelSearchDate
     * @param endCancelSearchDate
     * @param isOffline
     * @param payType
     * @param isMobile
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getCancelOrderListCount(String startSearchDate, String endSearchDate, String startCancelSearchDate,
                                       String endCancelSearchDate, int isOffline, int payType, int isMobile,
                                       String searchType, String searchText) {
        if ("".equals(startSearchDate) && "".equals(endSearchDate)
                && "".equals(startCancelSearchDate) && "".equals(endCancelSearchDate)) {
            return 0;
        }
        return orderManageMapper.selectCancelOrderListCount(
                Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                Util.isNullValue(startCancelSearchDate, ""), Util.isNullValue(endCancelSearchDate, ""),
                isOffline, payType, isMobile,
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

}
