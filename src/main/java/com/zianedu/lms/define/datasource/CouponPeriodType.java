package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 *  쿠폰 사용기간 타입 정의
 */
public enum CouponPeriodType {

    //발행일 기준
    PUBLISH(0, "발행일 기준"),
    //지정기간
    APPOINT(1, "지정기간")
    ;

    int couponPeriodKey;

    String couponPeriodStr;

    CouponPeriodType(int couponPeriodKey, String couponPeriodStr) {
        this.couponPeriodKey = couponPeriodKey;
        this.couponPeriodStr = couponPeriodStr;
    }
    public static String getCouponPeriodStr(int couponPeriodKey) {
        for (CouponPeriodType couponPeriodTypeType : CouponPeriodType.values()) {
            if (couponPeriodKey == couponPeriodTypeType.couponPeriodKey) {
                return couponPeriodTypeType.couponPeriodStr;
            }
        }
        return null;
    }

    public static List<SelectboxDTO> getCouponPeriodTypeSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (CouponPeriodType periodType : CouponPeriodType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    periodType.couponPeriodKey,
                    periodType.couponPeriodStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }

}
