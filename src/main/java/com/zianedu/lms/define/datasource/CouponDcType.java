package com.zianedu.lms.define.datasource;

/**
 * 쿠폰 할인 방식 정의
 */
public enum CouponDcType {

    PRICE(0, "할인가"),
    PERCENT(1,"할인률")
    ;

    int couponDcTypeKey;

    String couponDcTypeStr;

    CouponDcType(int couponDcTypeKey, String couponDcTypeStr) {
        this.couponDcTypeKey = couponDcTypeKey;
        this.couponDcTypeStr = couponDcTypeStr;
    }

    public static String getCouponDcTypeStr(int couponDcTypeKey) {
        for (CouponDcType couponDcType : CouponDcType.values()) {
            if (couponDcTypeKey == couponDcType.couponDcTypeKey) {
                return couponDcType.couponDcTypeStr;
            }
        }
        return null;
    }

}
