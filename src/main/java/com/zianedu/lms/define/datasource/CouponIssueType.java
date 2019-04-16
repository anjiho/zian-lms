package com.zianedu.lms.define.datasource;

/**
 * 쿠폰 발행 방식 정의
 */
public enum CouponIssueType {

    ADMIN(0, "관리자발급"),
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
}
