package com.zianedu.lms.utils;

import com.zianedu.lms.define.datasource.*;

import java.math.BigDecimal;

public class Test {
    //온라인 강좌 단일 상품 정산 계산 (t_order_promotion.pm_type = 0)
    public static double calcSingleProduct() {
        //만약에 동영상에 등록된 강사가 2명이면 price / 강사수
        int price = 15000; //t_order.price
        int couponDcPrice = 0;  //t_order_goods.coupon_dc_price
        int dcWellFare = 0; //t_order.dc_delfare
        int caclRate = 40;  //t_goods.calculate_rate
        int teacherCalcRate = 100;  //100고정
        int jGCount = 1;    //단일상품은 1고정
        int dcPoint = 1000; //t_order.dc_point
        int dcFree = 0; //t_order.dc_free
        float calcCalculateRate = caclRate * (teacherCalcRate / 100);
        double payCharge = 0.038;   //t_order.pay_type : 0, 22 이면 0.038 그외 없음

        float calcPrice = ( price - (dcWellFare / jGCount) - (dcFree / jGCount) )
                                * ( calcCalculateRate / 100 )
                                    - couponDcPrice
                                        - (dcPoint / jGCount);

        double calcPriceResult =  (calcPrice - (calcPrice * payCharge));
        return calcPriceResult;
    }

    //온라인 강좌 자유패키지 계산 t_order_promotion.pm_type = 2
    public static double calcFreePackageProduct() {
        //140000 ->  t_goods_price_option.sellPrice
        //400000 --> t_order_goods.sellPrice
        //500000 -> 상품들의 t_goods_price_option.sellPrice 합
        double price = 140000 * (1.0 * 400000) / 500000;   //프로모션 타입이 2일떄 (pm_type = 2)
        int couponDcPrice = 0;  //t_order_goods.coupon_dc_price
        int dcWellFare = 0; //t_order.dc_delfare
        int caclRate = 30;  //t_goods.calculate_rate
        int teacherCalcRate = 100;  //100고정
        int jGCount = 1;    // 1고정
        int dcPoint = 3000; //t_order.dc_point
        int dcFree = 0; //t_order.dc_free
        float calcCalculateRate = caclRate * (teacherCalcRate / 100);
        double payCharge = 0.038;   //t_order.pay_type : 0, 22 이면 0.038 그외 없음

        float calcPrice = ( (int)price - (dcWellFare / jGCount) - (dcFree / jGCount) )
                * ( calcCalculateRate / 100 )
                - couponDcPrice
                - (dcPoint / jGCount);

        double calcPriceResult =  (calcPrice - (calcPrice * payCharge));
        return calcPriceResult;
    }

    //온라인 강좌 패키지 계산 t_order_promotion.pm_type = 1
    public static double calcPackageProduct() {
        int sellPrice = 180000; //t_order_goods.sell_price
        int productCount = 2;   //select count(*) from t_order_goods where j_pm_key = {jPmKey}

        int price = sellPrice / productCount;
        int couponDcPrice = 0;  //t_order_goods.coupon_dc_price
        int dcWellFare = 0; //t_order.dc_delfare
        int caclRate = 30;  //t_goods.calculate_rate
        int teacherCalcRate = 100;  //100고정
        int jGCount = 1;    //  select count(*) from t_order_goods where j_key = 311956 총개수 (프로모션도 포함됨)
        int dcPoint = 3000; //t_order.dc_point (pm_type = 2 이면 각항목마다 할인된 가격 적용) jGCount 만큼 적용됨
        int dcFree = 0; //t_order.dc_free
        float calcCalculateRate = caclRate * (teacherCalcRate / 100);
        double payCharge = 0.038;   //t_order.pay_type : 0, 22 이면 0.038 그외 없음

        float calcPrice = ( price - (dcWellFare / jGCount) - (dcFree / jGCount) )
                * ( calcCalculateRate / 100 )
                - couponDcPrice
                - (dcPoint / jGCount);

        double calcPriceResult =  (calcPrice - (calcPrice * payCharge));
        return calcPriceResult;
    }

    //학원강의 정산
    public static double calcAcademyLectureProduct() {
        int price = 70000; //t_order.price
        int couponDcPrice = 0;  //t_order_goods.coupon_dc_price
        int dcWellFare = 0; //t_order.dc_delfare
        int caclRate = 50;  //t_goods.calculate_rate
        int teacherCalcRate = 100;  //100고정
        int jGCount = 1;    //단일상품은 1고정
        int dcPoint = 0; //t_order.dc_point
        int dcFree = 10000; //t_order.dc_free
        float calcCalculateRate = caclRate * (teacherCalcRate / 100);
        double payCharge = 0.038;   //t_order.pay_type : 0, 22 이면 0.038 그외 없음

        float calcPrice = ( price - (dcWellFare / jGCount) - (dcFree / jGCount) )
                * ( calcCalculateRate / 100 )
                - couponDcPrice
                - (dcPoint / jGCount);

        double calcPriceResult =  (calcPrice - (calcPrice * payCharge));
        return calcPriceResult;
    }

    public static void main(String[] args) {

        //System.out.println(DeliveryStatusType.getDeliveryStatusName());


    }
}
