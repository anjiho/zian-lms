package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

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

    public static List<SelectboxDTO> getCouponDcTypeSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (CouponDcType couponDcType : CouponDcType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    couponDcType.couponDcTypeKey,
                    couponDcType.couponDcTypeStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }

}
