package com.zianedu.lms.utils;

import com.zianedu.lms.dto.CalculateInfoDTO;

public class ZianCalculate {

    public static double calcSingleProduct(int price, int couponDcPrice, int dcWellFare, int caclRate,
                                           int dcPoint, int dcFree, double payCharge) {
        //만약에 동영상에 등록된 강사가 2명이면 price / 강사수
//        int price = 15000; //t_order.price
//        int couponDcPrice = 0;  //t_order_goods.coupon_dc_price
//        int dcWellFare = 0; //t_order.dc_delfare
//        int caclRate = 40;  //t_goods.calculate_rate
        int teacherCalcRate = 100;  //100고정
        int jGCount = 1;    //단일상품은 1고정
//        int dcPoint = 1000; //t_order.dc_point
//        int dcFree = 0; //t_order.dc_free
        float calcCalculateRate = caclRate * (teacherCalcRate / 100);
//        double payCharge = 0.038;   //t_order.pay_type : 0, 22 이면 0.038 그외 없음

        float calcPrice = ( price - (dcWellFare / jGCount) - (dcFree / jGCount) )
                * ( calcCalculateRate / 100 )
                - couponDcPrice
                - (dcPoint / jGCount);

        double calcPriceResult = 0;
        calcPriceResult = (calcPrice - (calcPrice * payCharge));
//        if (payType == 0 || payType == 22) {
//            calcPriceResult = (calcPrice - (calcPrice * payCharge));
//        } else {
//            calcPriceResult = calcPrice;
//        }
        return calcPriceResult;
    }

    public static double calcSingleProduct2(CalculateInfoDTO calculateInfoDTO) {
        int price = calculateInfoDTO.getPrice();
        int couponDcPrice = calculateInfoDTO.getCouponDcPrice();  //t_order_goods.coupon_dc_price
        int dcWellFare = calculateInfoDTO.getDcWelfare(); //t_order.dc_delfare
        int caclRate = calculateInfoDTO.getCalcCalculateRate();  //t_goods.calculate_rate
        int teacherCalcRate = calculateInfoDTO.getGTCalculateRate();
        int jGCount = calculateInfoDTO.getJGCount();    //단일상품은 1고정
        int dcPoint = calculateInfoDTO.getDcPoint(); //t_order.dc_point
        int dcFree = calculateInfoDTO.getDcFree(); //t_order.dc_free
        float calcCalculateRate = caclRate * (teacherCalcRate / 100);
        double payCharge = calculateInfoDTO.getPayCharge();   //t_order.pay_type : 0, 22 이면 0.038 그외 없음

        float calcPrice = ( price - (dcWellFare / jGCount) - (dcFree / jGCount) )
                * ( calcCalculateRate / 100 )
                - couponDcPrice
                - (dcPoint / jGCount);

        double calcPriceResult = 0;
        calcPriceResult = (calcPrice - (calcPrice * payCharge));

        return calcPriceResult;
    }
}
