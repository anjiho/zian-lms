package com.zianedu.lms.service;


import com.zianedu.lms.define.datasource.GoodsKindType;
import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.define.datasource.OrderPayStatusType;
import com.zianedu.lms.define.datasource.OrderPayType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.OrderManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.repository.GoodsKindNameRepository;
import com.zianedu.lms.repository.OrderLecStatusNameRepository;
import com.zianedu.lms.repository.OrderPayTypeNameRepository;
import com.zianedu.lms.repository.TeacherCalculateRepository;
import com.zianedu.lms.session.UserSession;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.StringUtils;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import org.apache.poi.ss.formula.functions.T;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
public class OrderManageService {

    final static Logger logger = LoggerFactory.getLogger(OrderManageService.class);

    @Autowired
    private OrderManageMapper orderManageMapper;

    @Autowired
    private GoodsKindNameRepository goodsKindNameRepository;

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private OrderLecStatusNameRepository orderLecStatusNameRepository;

    @Autowired
    private OrderPayTypeNameRepository orderPayTypeNameRepository;

    @Autowired
    private TeacherCalculateRepository teacherCalculateRepository;

    /**
     * 주문목록 조회
     * @param sPage
     * @param listLimit
     * @param startSearchDate 검색일 시작
     * @param endSearchDate 검색일 종료
     * @param goodsType 상품타입 GoodsType 정의
     * @Param payStatus 처리상태 (-1: 전체, 0 : 입금예정, 1 : 결제대기, 2 : 결제완료)
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
                                             int payStatus, int isOffline, int payType, int isMobile, String searchType, String searchText,
                                             int isVideoReply) {
        if (sPage == 0 && "".equals(startSearchDate) && "".equals(endSearchDate)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);


        List<OrderResultDTO>list = orderManageMapper.selectOrderList(
                startNumber, listLimit, Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                GoodsType.getGoodsTypeKey(goodsType), payStatus, isOffline, payType, isMobile,
                Util.isNullValue(searchText, ""), Util
                        .isNullValue(searchType, ""), isVideoReply
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
    public int getOrderListCount(String startSearchDate, String endSearchDate, String goodsType, int payStatus, int isOffline,
                            int payType, int isMobile, String searchType, String searchText, int isVideoReply) {

        return orderManageMapper.selectOrderListCount(
                Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                GoodsType.getGoodsTypeKey(goodsType), payStatus, isOffline, payType, isMobile,
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, ""), isVideoReply
        );
    }

    /**
     * 취소주문 리스트
     * @param sPage
     * @param listLimit
     * @param startSearchDate
     * @param endSearchDate
     * @param startCancelSearchDate
     * @param endCancelSearchDate
     * @param payStatus (-1 : 전체, 8 : 결제취소, 9 : 주문취소, 10 : 결제실패 )
     * @param isOffline
     * @param payType
     * @param isMobile
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<OrderResultDTO> getCancelOrderList(int sPage, int listLimit, String startSearchDate, String endSearchDate,
                                                   String startCancelSearchDate, String endCancelSearchDate, int payStatus,
                                                   int isOffline, int payType, int isMobile, String searchType, String searchText) {
        if (sPage == 0 && "".equals(startSearchDate) && "".equals(endSearchDate)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<OrderResultDTO>list = orderManageMapper.selectCancelOrderList(
                startNumber, listLimit, Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                Util.isNullValue(startCancelSearchDate, ""), Util.isNullValue(endCancelSearchDate, ""), payStatus,
                isOffline, payType, isMobile, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
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
     *  취소주문 리스트 개수
     * @param startSearchDate
     * @param endSearchDate
     * @param startCancelSearchDate
     * @param endCancelSearchDate
     * @param payStatus (-1 : 전체, 8 : 결제취소, 9 : 주문취소, 10 : 결제실패 )
     * @param isOffline
     * @param payType
     * @param isMobile
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getCancelOrderListCount(String startSearchDate, String endSearchDate, String startCancelSearchDate,
                                       String endCancelSearchDate, int payStatus, int isOffline, int payType, int isMobile,
                                       String searchType, String searchText) {
        if ("".equals(startSearchDate) && "".equals(endSearchDate)
                && "".equals(startCancelSearchDate) && "".equals(endCancelSearchDate)) {
            return 0;
        }
        return orderManageMapper.selectCancelOrderListCount(
                Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                Util.isNullValue(startCancelSearchDate, ""), Util.isNullValue(endCancelSearchDate, ""),
                payStatus, isOffline, payType, isMobile,
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

    /**
     * 수강관리 > 수강내역목록 리스트 가져오기
     * @return
     */
    @Transactional(readOnly = true)
    public List<OrderLectureListDTO> getVideoLectureWatchList(int sPage, int listLimit, String startSearchDate, String endSearchDate,
                                                              int payStatus, int orderLecStatus, String searchType, String searchText) {
        if (sPage == 0 && "".equals(startSearchDate) && "".equals(endSearchDate)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<OrderLectureListDTO>list = orderManageMapper.selectOrderLectureVideoList(
                startNumber, listLimit, Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                payStatus, orderLecStatus, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
        if (list.size() > 0) {
            //수강타입명 주입하기
            goodsKindNameRepository.injectGoodsKindNameAny(list);
            //진행상태명 주입하기
            orderLecStatusNameRepository.injectOrderLecStatusNameAny(list);
            //결제상태명 주입하기
            orderPayTypeNameRepository.injectOrderPayTypeNameAny(list);
        }
        return list;
    }

    /**
     * 수강관리 > 수강내역목록 리스트 개수
     * @param startSearchDate
     * @param endSearchDate
     * @param payStatus
     * @param orderLecStatus
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getVideoLectureWatchListCount(String startSearchDate, String endSearchDate,
                                             int payStatus, int orderLecStatus, String searchType, String searchText) {
        if ("".equals(startSearchDate) && "".equals(endSearchDate)) return 0;

        return orderManageMapper.selectOrderLectureVideoListCount(
                Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                payStatus, orderLecStatus, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

    /**
     * 수강관리 > 수강내역목록 > 수강시간 조정 데이터
     * @param jLecKey
     * @return
     */
    @Transactional(readOnly = true)
    public ResultDTO getUserLectureVideoDetailInfo(int jLecKey) {
        LectureTimeInfoDTO lectureTimeInfo = orderManageMapper.selectTOrderInfoAtLectureTime(jLecKey);
        List<LectureTimeDTO> lectureTimeInfoList = orderManageMapper.selectLectureTimeList(jLecKey);

        ResultDTO resultDTO = new ResultDTO();
        resultDTO.setResult(lectureTimeInfo);
        resultDTO.setResultList(lectureTimeInfoList);
        return resultDTO;
    }

    /**
     * 디바이스 관리 > 상품별 디바이스 관리 리스트 (PC 디바이스로 변경)
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<DeviceListDTO> getPcDeviceList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<DeviceListDTO>list = orderManageMapper.selectPcDeviceList(
                startNumber, listLimit, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
        return list;
    }

    /**
     * 디바이스 관리 > 상품별 디바이스 관리 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getPcDeviceListCount(String searchType, String searchText) {
        return orderManageMapper.selectPcDeviceListCount(
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

    /**
     * 디바이스 관리 > 모바일 디바이스 관리 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<DeviceListDTO> getMobileDeviceList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);

        List<DeviceListDTO>list = orderManageMapper.selectMobileDeviceList(
                startNumber, listLimit, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
        return list;
    }

    /**
     * 디바이스 관리 > 모바일 디바이스 관리 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getMobileDeviceListCount(String searchType, String searchText) {
        return orderManageMapper.selectMobileDeviceListCount(
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

    /**
     * 디바이스 관리 > 기기변경 이력 조회 리스트
     * @param sPage
     * @param listLimit
     * @param searchStartDate
     * @param searchEndDate
     * @param deviceType
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<DeviceListDTO> getDeviceChangeLogList(int sPage, int listLimit, String searchStartDate, String searchEndDate,
                                                      String deviceType, String searchType, String searchText) {
        if (sPage == 0 && "".equals(searchStartDate) && "".equals(searchEndDate)) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        List<DeviceListDTO>list = orderManageMapper.selectDeviceChangeLogList(
                startNumber, listLimit, Util.isNullValue(searchStartDate, ""), Util.isNullValue(searchEndDate, ""),
                Util.isNullValue(deviceType.toLowerCase(), ""), Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );

        if (list.size() > 0) {
            for (DeviceListDTO deviceListDTO : list) {
                //PC일때 상품명 주입
                if (deviceListDTO.getType() == 0) {
                    String goodsName = orderManageMapper.selectGoodsNameByJGKey(deviceListDTO.getDataKey());
                    deviceListDTO.setGoodsName(goodsName);
                }
            }
        }
        return list;
    }

    /**
     * 디바이스 관리 > 기기변경 이력 조회 리스트 개수
     * @param searchStartDate
     * @param searchEndDate
     * @param deviceType
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getDeviceChangeLogListCount(String searchStartDate, String searchEndDate, String deviceType,
                                           String searchType, String searchText) {
        if ("".equals(searchStartDate) && "".equals(searchEndDate)) return 0;
        return orderManageMapper.selectDeviceChangeLogListCount(
                Util.isNullValue(searchStartDate, ""), Util.isNullValue(searchEndDate, ""),
                Util.isNullValue(deviceType.toLowerCase(), ""), Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

    /**
     * 마일리지 관리 리스트
     * @param sPage
     * @param listLimit
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public List<PointListDTO> getUserPointList(int sPage, int listLimit, String searchType, String searchText) {
        if (sPage == 0) return null;

        int startNumber = PagingSupport.getPagingStartNumber(sPage, listLimit);
        List<PointListDTO>list = orderManageMapper.selectTPointList(
                startNumber, listLimit, Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
        return list;
    }

    /**
     * 마일리지 관리 리스트 개수
     * @param searchType
     * @param searchText
     * @return
     */
    @Transactional(readOnly = true)
    public int getUserPointListCount(String searchType, String searchText) {
        return orderManageMapper.selectTPointListCount(
                Util.isNullValue(searchType, ""), Util.isNullValue(searchText, "")
        );
    }

    /**
     * 주문상세보기
     * @param jKey
     * @return
     */
    @Transactional(readOnly = true)
    public OrderDetailDTO getOrderDetail(int jKey) {
        OrderDetailInfoDTO orderDetailInfoDTO = orderManageMapper.selectOrderDetailInfo(jKey);
        if (orderDetailInfoDTO != null) {
            orderDetailInfoDTO.setPayStatusName(OrderPayStatusType.getOrderPayStatusStr(orderDetailInfoDTO.getPayStatus()));
            orderDetailInfoDTO.setPayTypeName(OrderPayType.getOrderPayTypeStr(orderDetailInfoDTO.getPayType()));
            orderDetailInfoDTO.setCashReceiptTypeName(CashReceiptType.getCashReceiptTypeStr(orderDetailInfoDTO.getCashReceiptType()));
        }
        List<OrderDetailProductListDTO> orderProductList = orderManageMapper.selectOrderDetailProductList(jKey);
        if (orderProductList.size() > 0) {
            for (OrderDetailProductListDTO productListDTO : orderProductList) {
                productListDTO.setProductTypeName(OrderGoodsType.getGoodsTypeStr(productListDTO.getType()));
                if (productListDTO.getKind() > 0 && productListDTO.getKind() < 13) {
                    productListDTO.setProductOptionName(productListDTO.getKind() + "개월");
                } else {
                    productListDTO.setProductOptionName(GoodsKindType.getGoodsKindName(productListDTO.getKind()));
                }
            }
        }
        TUserVO orderUserInfo = orderManageMapper.selectOrderUserInfo(jKey);
        TUserVO deliveryUserInfo = orderManageMapper.selectDeliveryUserInfo(jKey);
        DeliveryAddressDTO deliveryAddressInfo = orderManageMapper.selectDeliveryAddressInfo(jKey);
        TOrderDeliveryVO deliveryInfo = orderManageMapper.selectDeliveryInfo(jKey);

        return new OrderDetailDTO(orderDetailInfoDTO, orderProductList, orderUserInfo, deliveryUserInfo, deliveryInfo, deliveryAddressInfo);
    }

    /**
     * 수강관리 > 수강내역목록 > 수강시간 조정 > 시간 수정 (배열이아닌 건 바이 건)
     * @param jCurriKey
     * @param jLecKey
     * @param curriKey
     * @param time
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void changeUserLectureTime(int jCurriKey, int jLecKey, int curriKey, int time) {
        if (jLecKey == 0 && curriKey == 0) return;

        TOrderLecCurriVO lecCurriVO = new TOrderLecCurriVO(
                (long)jCurriKey,
                (long)jLecKey,
                (long)curriKey,
                time
        );
        if (jCurriKey == 0) {
            orderManageMapper.insertTOrderLecCurri(lecCurriVO);
        } else {
            orderManageMapper.updateTOrderLecCurri(lecCurriVO);
        }
    }

    /**
     * 수강관리 > 수강내역목록 > 수강타입, 진행상태 수정 ( UI 새로 구성 --> 한번에 표현 후 수정 )
     * @param jLecKey
     * @param kind
     * @param status
     * @param startDate
     * @param endDate
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateUserLectureInfo(Long jLecKey, int kind, int status, String startDate, String endDate) {
        if (jLecKey == 0L) return;

        String searchStartDate = "";
        String searchEndDate = "";

        if (!"".equals(startDate)) {
            String[] startDates = Util.split(startDate, "-");
            searchStartDate = startDates[0] + startDates[1] + startDates[2];
        }
        if (!"".equals(endDate)) {
            String[] endDates = Util.split(endDate, "-");
            searchEndDate = endDates[0] + endDates[1] + endDates[2];
        }
        int limitDay = Util.getDiffDayCount(searchStartDate, searchEndDate);

        Long jGKey = orderManageMapper.selectJGKeyByJLecKey(jLecKey);
        if (jGKey != null || jGKey > 0L) {
            orderManageMapper.updateTOrderGoodsKind(jGKey, kind);
        }
        orderManageMapper.updateTOrderLec(jLecKey, status, limitDay);
    }

    /**
     * 수강관리 > 학원수강입력
     * @param userKey
     * @param goodsKeyList
     * @param price
     * @param payType
     * @param cardCode
     * @param memoTitle
     * @param memoContent
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int saveAcademyLecture(Integer userKey, List<Integer>goodsKeyList, int price, int payType,
                                   String cardCode, String memoTitle, String memoContent) throws Exception {
        if (userKey == 0 && goodsKeyList.size() == 0 && price == 0) return 0;

        TOrderVO tOrderVO = new TOrderVO(userKey, price, payType, cardCode);
        //T_ORDER 결제정보 저장
        orderManageMapper.insertTOrder(tOrderVO);

        int jKey = tOrderVO.getJKey();
        if (jKey > 0) {
            for (Integer goodsKey : goodsKeyList) {
                //상품의 강사이름 조회
                List<String>teacherName = productManageMapper.selectTeacherNameListByVideoProduct(goodsKey);
                //상품의 강좌 조회
                TLecVO tLecVO = productManageMapper.selectTLecInfo(goodsKey);
                //상품의 가격 조회
                List<TGoodsPriceOptionVO>goodsPriceOptionList = productManageMapper.selectTGoodsPriceOptionList(goodsKey);
                //상품 기본정보 조회
                TGoodsVO tGoodsVO = productManageMapper.selectTGoodsInfo(goodsKey);

                if (tLecVO != null && goodsPriceOptionList.size() > 0) {
                    TOrderGoodsVO tOrderGoodsVO = new TOrderGoodsVO(
                            jKey, userKey, goodsKey, goodsPriceOptionList.get(0).getPriceKey(), price,
                            goodsPriceOptionList.get(0).getKind(), tLecVO.getExamYear(), tLecVO.getClassGroupCtgKey(),
                            tLecVO.getSubjectCtgKey(), teacherName.get(0), tGoodsVO.getName()
                    );
                    //T_ORDER_GOODS 결제 상품 저장
                    orderManageMapper.insertTOrderGoods(tOrderGoodsVO);
                }
            }
            if (!"".equals(memoTitle)) {
                //메모 정보 저장
                int sendUserKey = UserSession.get() == null ? 5 : UserSession.getUserKey();
                TMemoVO tMemoVO = new TMemoVO(jKey, sendUserKey, Util.isNullValue(memoTitle, ""), Util.isNullValue(memoContent, ""));
                orderManageMapper.insertTMemo(tMemoVO);
            }
        }
        return jKey;
    }

    /**
     * 수강관리 > 무료수강입력
     * @param priceKeyList
     * @param userKeyList
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int injectFreeVideoLecture(List<Integer>priceKeyList, List<Integer>userKeyList, int status, String startDate, String endDate) throws Exception {
        if (priceKeyList.size() == 0 && userKeyList.size() == 0) return 0;
        int jKey = 0;

        for (Integer userKey : userKeyList) {
            for (Integer priceKey : priceKeyList) {
                TGoodsPriceOptionVO tGoodsPriceOptionVO = productManageMapper.selectTGoodsPriceOptionInfo(priceKey);
                int gKey = tGoodsPriceOptionVO.getGKey();
                //상품의 강사이름 조회
                List<String>teacherNameList = productManageMapper.selectTeacherNameListByVideoProduct(gKey);
                //상품의 강좌 조회
                TLecVO tLecVO = productManageMapper.selectTLecInfo(gKey);
                //상품의 가격 조회
                List<TGoodsPriceOptionVO>goodsPriceOptionList = productManageMapper.selectTGoodsPriceOptionList(gKey);
                //상품 기본정보 조회
                TGoodsVO tGoodsVO = productManageMapper.selectTGoodsInfo(gKey);

                TOrderVO tOrderVO = new TOrderVO(userKey, 0, 20, "0");
                orderManageMapper.insertTOrder(tOrderVO);

                jKey = tOrderVO.getJKey();
                if (jKey > 0) {
                    if (tLecVO != null && goodsPriceOptionList.size() > 0) {

                        String teacherName = "";
                        //선생님 이름 만들기
                        if (teacherNameList.size() > 0) {
                            teacherName = StringUtils.implodeList(",", teacherNameList);
                        }
                        TOrderGoodsVO tOrderGoodsVO = new TOrderGoodsVO(
                                jKey, userKey, gKey, priceKey, 0,
                                tGoodsPriceOptionVO.getKind(), tLecVO.getExamYear(), tLecVO.getClassGroupCtgKey(),
                                tLecVO.getSubjectCtgKey(), teacherName, tGoodsVO.getName()
                        );
                        //T_ORDER_GOODS 결제 상품 저장
                        orderManageMapper.insertTOrderGoods(tOrderGoodsVO);

                        int jGKey = tOrderGoodsVO.getJGKey();
                        if (jGKey > 0) {
                            int limitDay = 0;
                            if ("".equals(endDate)) limitDay = tLecVO.getLimitDay();    //수강일수 설정값이 아닐때
                            else limitDay = Util.getDiffDayCount(Util.convertToYYYYMMDD(startDate), Util.convertToYYYYMMDD(endDate));   //수강일수 설정값일때

                            TOrderLecVO tOrderLecVO = new TOrderLecVO(
                                    jGKey, status, startDate, limitDay, tLecVO.getMultiple()
                            );
                            //T_ORDER_LEC 동영상 상품 저장
                            orderManageMapper.insertTOrderLec(tOrderLecVO);
                        }
                    }
                }
            }
        }
        return jKey;
    }

    /**
     * 사용자 마일리지 추가 및 빼기
     * @param injectType(P : 추가, M : 빼기)
     * @param userKey
     * @param point
     * @param description
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void injectUserPoint(String injectType, int userKey, int point, String description) {
        if (userKey == 0 && "".equals(injectType) && point == 0) return;

        if ("M".equals(injectType)) {
            point = -point;
        }
        TPointVO tPointVO = new TPointVO(userKey, point, description);
        orderManageMapper.insertTPoint(tPointVO);
    }

    /**
     * 디바이스 관리 리스트 > 삭제하기
     * @param deviceLimitKey
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteUserDeviceLimit(int deviceLimitKey) {
        if (deviceLimitKey == 0) return;

        TDeviceLimitVO tDeviceLimitVO = orderManageMapper.selectTDeviceLimitInfo(deviceLimitKey);
        if (tDeviceLimitVO != null) {
            String[] indates = StringUtils.splitComma(tDeviceLimitVO.getIndate());
            TDeviceLimitLogVO limitLogVO = new TDeviceLimitLogVO(
                    tDeviceLimitVO.getDeviceLimitKey(), tDeviceLimitVO.getCKey(), tDeviceLimitVO.getUserKey(), indates[0],
                    tDeviceLimitVO.getType(), tDeviceLimitVO.getDataKey(), tDeviceLimitVO.getDeviceId(),
                    tDeviceLimitVO.getDeviceModel(), tDeviceLimitVO.getOsVersion(), tDeviceLimitVO.getAppVersion()
            );
            orderManageMapper.insertTDeviceLimitLog(limitLogVO);
        }
        orderManageMapper.deleteTDeviceLimit(deviceLimitKey);
    }

    /**
     * 결제상태 변경하기
     * @param list
     */
    public void changePayStatus(List<HashMap<String, String>>list) {
        if (list.size() == 0) return;
        for (HashMap<String, String>paramMap : list) {
            int jKey = Integer.parseInt(paramMap.get("jKey"));
            int payStatus = Integer.parseInt(paramMap.get("payStatus"));

            if (jKey > 0) {
                orderManageMapper.updateOrderStatus(jKey, payStatus);
            }
        }
    }

    /**
     * 배송정보 저장및 수정
     * @param jKey
     * @param deliveryMasterKey
     * @param status
     * @param deliveryNo
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveDeliveryInfo(int jDeliveryKey, int jKey, int deliveryMasterKey, int status, String deliveryNo) {
        if (jKey == 0) return;

        String endDate = "";
        if (status == 2) endDate = Util.returnNow();

        if (jDeliveryKey == 0) {
            //저장
            TOrderDeliveryVO deliveryInfo = new TOrderDeliveryVO(
                    jKey, deliveryMasterKey, status, deliveryNo, endDate
            );
            orderManageMapper.insertTOrderDelivery(deliveryInfo);
        } else {
            //수정
            TOrderDeliveryVO deliveryInfo = new TOrderDeliveryVO(
                    jDeliveryKey, jKey, status, deliveryMasterKey, deliveryNo, endDate
            );
            orderManageMapper.updateTOrderDelivery(deliveryInfo);
        }
    }

    /**
     * 배송지 정보 저장
     * @param jKey
     * @param deliveryName
     * @param deliveryEmail
     * @param deliveryTelephone
     * @param deliveryTelephoneMobile
     * @param deliveryZipcode
     * @param deliveryAddress
     * @param deliveryAddressRoad
     * @param deliveryAddressAdd
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveDeliveryAddressInfo(int jKey, String deliveryName, String deliveryEmail, String deliveryTelephone,
                                        String deliveryTelephoneMobile, String deliveryZipcode, String deliveryAddress,
                                        String deliveryAddressRoad, String deliveryAddressAdd) {
        if (jKey == 0) return;
        DeliveryAddressDTO deliveryAddressDTO = new DeliveryAddressDTO(
                jKey, deliveryName, deliveryTelephone, deliveryTelephoneMobile, deliveryEmail,
                deliveryZipcode, deliveryAddress, deliveryAddressRoad, deliveryAddressAdd
        );
        orderManageMapper.updateOrderDeliveryInfo(deliveryAddressDTO);
    }

}
