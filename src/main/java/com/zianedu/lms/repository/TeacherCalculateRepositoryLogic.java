package com.zianedu.lms.repository;

import com.zianedu.lms.dto.CalculateInfoDTO;
import com.zianedu.lms.mapper.MemberManageMapper;
import com.zianedu.lms.mapper.OrderManageMapper;
import com.zianedu.lms.mapper.ProductManageMapper;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.utils.ZianCalculate;
import com.zianedu.lms.vo.TCalculateVO;
import com.zianedu.lms.vo.TGoodTeacherLinkVO;
import com.zianedu.lms.vo.TTeacherVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class TeacherCalculateRepositoryLogic implements TeacherCalculateRepository {

    static final Logger logger = LoggerFactory.getLogger(TeacherCalculateRepository.class);

    @Autowired
    private OrderManageMapper orderManageMapper;

    @Autowired
    private MemberManageMapper memberManageMapper;

    @Autowired
    private ProductManageMapper productManageMapper;

    @Override
    public void calculateTeacherSaleGoodsAny(String yyyymmdd) throws Exception {
        //정산할 강사 조회
        List<TTeacherVO> calculateTeacherList = memberManageMapper.selectCalculateTeacherList();

        if (calculateTeacherList == null || calculateTeacherList.size() == 0) return;
        //강사만큼 배열 시작
        for (TTeacherVO teacherVO : calculateTeacherList) {
            TCalculateVO tCalculateVO = new TCalculateVO(teacherVO.getTeacherKey());
            //T_CALCULATE 테이블 내용 저장
            //Long calculateKey = orderManageMapper.insertTCalculate(tCalculateVO);
            //주문내역 조회
            //List<CalculateInfoDTO> orderInfoList = orderManageMapper.selectCalculateInfoBySchedule(Util.plusDate(Util.returnNow(), -1));
            List<CalculateInfoDTO> orderInfoList = orderManageMapper.selectCalculateInfoBySchedule(yyyymmdd);
            //주문내역만큼 배열 시작
            for (CalculateInfoDTO calculateInfoDTO : orderInfoList) {
                int gKey = calculateInfoDTO.getGKey();
                int calculateRate = orderManageMapper.selectCalculateRateTGoods(gKey);
                //1. 상품이 동영상일때
                if (calculateInfoDTO.getType() == 1) {
                    //동영상 상품에 등록되어 있는 강사 조회
                    List<TGoodTeacherLinkVO> teacherLinkVOS = productManageMapper.selectTeacherListByTeacherLink(gKey);

                    int teacherSize = teacherLinkVOS.size();
                    if (teacherLinkVOS.size() > 0 || teacherLinkVOS != null) {
                        for (TGoodTeacherLinkVO teacherLinkVO : teacherLinkVOS) {
                            int price = calculateInfoDTO.getPrice();
                            if (teacherSize > 1) {
                                price = price / 2;
                            }
                            //정산금액 계산하기
                            double calcPrice = ZianCalculate.calcSingleProduct(
                                price, calculateInfoDTO.getCouponDcPrice(), calculateInfoDTO.getDcWelfare(), calculateRate,
                                calculateInfoDTO.getDcPoint(), calculateInfoDTO.getDcFree(), calculateInfoDTO.getPayType()
                            );
                            logger.info("calcPrice >>>>>>>>>>>>>>>> " + calcPrice);
                        }
                    }
                }

            }

        }


    }
}
