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
    private ScheduleManageMapper scheduleManageMapper;

    /**
     * 일단위 강사 판매 금액 정산하기
     * @param yyyymmdd
     * @throws Exception
     */
    @Override
    public void calculateTeacherSaleGoodsAny(String yyyymmdd) throws Exception {
        if ("".equals(yyyymmdd)) {
            logger.error("******************* yyyymmdd is null!! *******************");
            return;
        }

        logger.info("===============================================================");
        logger.info("정산 시작 + (" + yyyymmdd + ")");

        List<TTeacherVO> calculateTeacherList = memberManageMapper.selectCalculateTeacherList();

        if (calculateTeacherList.size() == 0 || calculateTeacherList == null) {
            logger.error("******************* calculateTeacherList is null!! *******************");
            return;
        }

        //강사만큼 배열 시작
        for (TTeacherVO teacherVO : calculateTeacherList) {
            logger.info("===============================================================");
            logger.info("강사 넘버 + (" + teacherVO.getTeacherKey() + ") 정산");

            TCalculateVO tCalculateVO = new TCalculateVO(teacherVO.getTeacherKey());
            //T_CALCULATE 테이블 내용 저장
            orderManageMapper.insertTCalculate(tCalculateVO);
            Long calculateKey = tCalculateVO.getCalculateKey();

            //계산된 정상 결제 목록
            List<CalculateInfoDTO>calculateInfoListByPayDate = scheduleManageMapper.selectCalculateListAtYesterdayByPayDate(yyyymmdd, teacherVO.getTeacherKey());
            //계산된 취소 결제 목록
            List<CalculateInfoDTO>calculateInfoListByCancelDate = scheduleManageMapper.selectCalculateListAtYesterdayByCancelDate(yyyymmdd, teacherVO.getTeacherKey());

            //계산된 정상 결제 목록 저장
            if (calculateInfoListByPayDate.size() > 0) {
                logger.info("===============================================================");
                logger.info("정상 결제 목록 정산 시작");
                //calculateKey, payStatus 주입
                calculateInfoListByPayDate.stream()
                        .peek(calculateInfoDTO -> calculateInfoDTO.setCalculateKey(calculateKey))
                        .peek(calculateInfoDTO -> calculateInfoDTO.setPayStatus(2))
                        .collect(Collectors.toList());

                for (CalculateInfoDTO calculateInfoDTO : calculateInfoListByPayDate) {
                    TCalculateDataVO tCalculateDataVO = new TCalculateDataVO(calculateInfoDTO);
                    orderManageMapper.insertTCalculateData(tCalculateDataVO);
                }
                logger.info("===============================================================");
                logger.info("정상 결제 목록 " + calculateInfoListByPayDate.size() + " 건 저장");
            }

            //계산된 취소 결제 목록 저장
            if (calculateInfoListByCancelDate.size() > 0) {
                logger.info("===============================================================");
                logger.info("취소 결제 목록 정산 시작");
                //calculateKey, payStatus 주입
                calculateInfoListByCancelDate.stream()
                        .peek(calculateInfoDTO -> calculateInfoDTO.setCalculateKey(calculateKey))
                        .peek(calculateInfoDTO -> calculateInfoDTO.setPayStatus(8))
                        .collect(Collectors.toList());

                for (CalculateInfoDTO calculateInfoDTO : calculateInfoListByCancelDate) {
                    TCalculateDataVO tCalculateDataVO = new TCalculateDataVO(calculateInfoDTO);
                    orderManageMapper.insertTCalculateData(tCalculateDataVO);
                }
                logger.info("===============================================================");
                logger.info("취소 결제 목록 " + calculateInfoListByCancelDate.size() + " 건 저장");
            }
        }
        logger.info("===============================================================");
        logger.info("정산 끝");
    }
}
