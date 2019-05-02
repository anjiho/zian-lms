package com.zianedu.lms.service;


import com.zianedu.lms.define.datasource.GoodsType;
import com.zianedu.lms.define.datasource.OrderPayStatusType;
import com.zianedu.lms.define.datasource.OrderPayType;
import com.zianedu.lms.dto.*;
import com.zianedu.lms.mapper.OrderManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.repository.GoodsKindNameRepository;
import com.zianedu.lms.repository.OrderLecStatusNameRepository;
import com.zianedu.lms.repository.OrderPayTypeNameRepository;
import com.zianedu.lms.session.UserSession;
import com.zianedu.lms.utils.PagingSupport;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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

        List<OrderResultDTO>list = orderManageMapper.selectCancelOrderList(
                startNumber, listLimit, Util.isNullValue(startSearchDate, ""), Util.isNullValue(endSearchDate, ""),
                Util.isNullValue(startCancelSearchDate, ""), Util.isNullValue(endCancelSearchDate, ""),
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
     * 수강관리 > 무료수강입력 (강의시작일, 강의종료일, 수강일수, 시작대기 값 개발해야함)
     * @param priceKeyList
     * @param userKeyList
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int injectFreeVideoLecture(List<Integer>priceKeyList, List<Integer>userKeyList) throws Exception {
        if (priceKeyList.size() == 0 && userKeyList.size() == 0) return 0;
        int jKey = 0;

        for (Integer userKey : userKeyList) {
            for (Integer priceKey : priceKeyList) {
                TGoodsPriceOptionVO tGoodsPriceOptionVO = productManageMapper.selectTGoodsPriceOptionInfo(priceKey);
                int gKey = tGoodsPriceOptionVO.getGKey();
                //상품의 강사이름 조회
                List<String>teacherName = productManageMapper.selectTeacherNameListByVideoProduct(gKey);
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
                        TOrderGoodsVO tOrderGoodsVO = new TOrderGoodsVO(
                                jKey, userKey, gKey, goodsPriceOptionList.get(0).getPriceKey(), 0,
                                tGoodsPriceOptionVO.getKind(), tLecVO.getExamYear(), tLecVO.getClassGroupCtgKey(),
                                tLecVO.getSubjectCtgKey(), teacherName.get(0), tGoodsVO.getName()
                        );
                        //T_ORDER_GOODS 결제 상품 저장
                        orderManageMapper.insertTOrderGoods(tOrderGoodsVO);
                    }
                }
            }
        }
        return jKey;
    }

}
