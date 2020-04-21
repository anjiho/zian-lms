package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * 쿠폰 발행 방식 정의
 */
public enum CouponIssueType {

    ADMIN(0, "온라인"),
    OFFLINE(1, "오프라인")
    ;

    int couponIssueTypeKey;

    String couponIssueTypeStr;

    CouponIssueType(int couponIssueTypeKey, String couponIssueTypeStr) {
        this.couponIssueTypeKey = couponIssueTypeKey;
        this.couponIssueTypeStr = couponIssueTypeStr;
    }

    public static String getCouponIssueTypeStr(int couponIssueTypeKey) {
        for (CouponIssueType couponIssueType : CouponIssueType.values()) {
            if (couponIssueTypeKey == couponIssueType.couponIssueTypeKey) {
                return couponIssueType.couponIssueTypeStr;
            }
        }
        return null;
    }

    public static List<SelectboxDTO> getCouponIssueTypeSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (CouponIssueType issueType : CouponIssueType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    issueType.couponIssueTypeKey,
                    issueType.couponIssueTypeStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }
}
