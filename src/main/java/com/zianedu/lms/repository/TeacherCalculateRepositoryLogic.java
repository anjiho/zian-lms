package com.zianedu.lms.repository;

import com.zianedu.lms.dto.CalculateInfoDTO;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.mapper.OrderManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.mapper.ScheduleManageMapper;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.vo.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class TeacherCalculateRepositoryLogic implements TeacherCalculateRepository {

    static final Logger logger = LoggerFactory.getLogger(TeacherCalculateRepository.class);

    @Autowired
    private OrderManageMapper orderManageMapper;

    @Autowired
    private MemberManageMapper memberManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

    @Autowired
    private ScheduleManageMapper scheduleManageMapper;

    /**
     *
     * @param yyyymmdd
     * @throws Exception
     */
    @Override
    public void calculateTeacherSaleGoodsAny(String yyyymmdd) throws Exception {

        logger.info(">>>>>>>>>>>>>>>>>>>>>>>>");

        List<TTeacherVO> calculateTeacherList = memberManageMapper.selectCalculateTeacherList();

        if (calculateTeacherList.size() == 0 || calculateTeacherList == null) return;

        //강사만큼 배열 시작
        for (TTeacherVO teacherVO : calculateTeacherList) {
            TCalculateVO tCalculateVO = new TCalculateVO(teacherVO.getTeacherKey());
            //T_CALCULATE 테이블 내용 저장
            orderManageMapper.insertTCalculate(tCalculateVO);
            Long calculateKey = tCalculateVO.getCalculateKey();
                    //주문목록중에 강사의 주문목록 가져오기(핵심)
            //List<CalculateInfoDTO>calculateInfoList = scheduleManageMapper.selectCalculateListAtYesterday(yyyymmdd, teacherVO.getTeacherKey());
            List<CalculateInfoDTO>calculateInfoListByPayDate = scheduleManageMapper.selectCalculateListAtYesterdayByPayDate(yyyymmdd, teacherVO.getTeacherKey());
            List<CalculateInfoDTO>calculateInfoListByCancelDate = scheduleManageMapper.selectCalculateListAtYesterdayByCancelDate(yyyymmdd, teacherVO.getTeacherKey());

            if (calculateInfoListByPayDate.size() > 0) {
                calculateInfoListByPayDate.stream()
                        .peek(calculateInfoDTO -> calculateInfoDTO.setCalculateKey(calculateKey))
                        .peek(calculateInfoDTO -> calculateInfoDTO.setPayStatus(2))
                        .collect(Collectors.toList());

                for (CalculateInfoDTO calculateInfoDTO : calculateInfoListByPayDate) {
                    //Long calculateDataKey = orderManageMapper.selectTCalculateDataSeq();
                    TCalculateDataVO tCalculateDataVO = new TCalculateDataVO(calculateInfoDTO);

                    orderManageMapper.insertTCalculateData(tCalculateDataVO);
                }
            }

            if (calculateInfoListByCancelDate.size() > 0) {
                calculateInfoListByCancelDate.stream()
                        .peek(calculateInfoDTO -> calculateInfoDTO.setCalculateKey(calculateKey))
                        .peek(calculateInfoDTO -> calculateInfoDTO.setPayStatus(8))
                        .collect(Collectors.toList());

                for (CalculateInfoDTO calculateInfoDTO : calculateInfoListByCancelDate) {
                    //Long calculateDataKey = orderManageMapper.selectTCalculateDataSeq();
                    TCalculateDataVO tCalculateDataVO = new TCalculateDataVO(calculateInfoDTO);

                    orderManageMapper.insertTCalculateData(tCalculateDataVO);
                }
            }
        }





        //정산할 강사 조회
//        List<TTeacherVO> calculateTeacherList = memberManageMapper.selectCalculateTeacherList();
//
//        if (calculateTeacherList == null || calculateTeacherList.size() == 0) return;
//        //강사만큼 배열 시작
//        for (TTeacherVO teacherVO : calculateTeacherList) {
//            TCalculateVO tCalculateVO = new TCalculateVO(teacherVO.getTeacherKey());
//            //T_CALCULATE 테이블 내용 저장
//            //Long calculateKey = orderManageMapper.insertTCalculate(tCalculateVO);
//            //주문내역 조회(T_ORDER)
//            //List<CalculateInfoDTO> orderInfoList = orderManageMapper.selectCalculateInfoBySchedule(Util.plusDate(Util.returnNow(), -1));
//            List<CalculateInfoDTO> orderInfoList = orderManageMapper.selectCalculateInfoBySchedule(yyyymmdd);
//
//            //주문내역만큼 배열 시작
//            for (CalculateInfoDTO calculateInfoDTO : orderInfoList) {
//                //T_ORDER_GOODS 테이블 조회
//                List<TOrderGoodsVO>orderGoodsList = orderManageMapper.selectTOrderGoods(calculateInfoDTO.getJKey());
//
//                //주문한 T_ORDER_GOODS 조회만큼
//                for (TOrderGoodsVO orderGoodsVO : orderGoodsList) {
//                    int gKey = orderGoodsVO.getGKey();
//                    //T_GOODS.CALCULATE_RATE 필드 조회
//                    int calculateRate = orderManageMapper.selectCalculateRateTGoods(gKey);
//
//                    //1. 상품이 동영상일때
//                    if (orderGoodsVO.getType() == 1) {
//                        //동영상 상품에 등록되어 있는 강사 조회
//                        List<TGoodTeacherLinkVO> teacherLinkVOS = productManageMapper.selectTeacherListByTeacherLink(gKey);
//
//                        int teacherSize = teacherLinkVOS.size();
//                        if (teacherLinkVOS.size() > 0 || teacherLinkVOS != null) {
//                            for (TGoodTeacherLinkVO teacherLinkVO : teacherLinkVOS) {
//                                int price = calculateInfoDTO.getPrice();
//                                if (teacherSize > 1) {
//                                    price = price / 2;
//                                }
//                                //정산금액 계산하기
//                                double calcPrice = ZianCalculate.calcSingleProduct(
//                                        price, calculateInfoDTO.getCouponDcPrice(), calculateInfoDTO.getDcWelfare(), calculateRate,
//                                        calculateInfoDTO.getDcPoint(), calculateInfoDTO.getDcFree(), calculateInfoDTO.getPayType()
//                                );
//                                logger.info("calcPrice >>>>>>>>>>>>>>>> " + calcPrice);
//                            }
//                        }
//                    }
//                }
//
//            }
//        }
//
    }
}
