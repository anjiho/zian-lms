package com.zianedu.lms.define.datasource;

public enum PromotionPmType {
    //패키지
    PACKAGE(1),
    //연간회원제
    YEAR_MEMBER(50),
    //연간회원제 페이지
    YEAR_MEMBER_PAGE(51),
    //지안패스
    ZIAN_PASS(100),
    //지안패스 페이지
    ZIAN_PASS_PAGE(101)
    ;

    int promotionPmTypekey;

    PromotionPmType(int promotionPmTypekey) {
        this.promotionPmTypekey = promotionPmTypekey;
    }

    public static int getPromotionPmTypeKey(String promotionPmTypeStr) {
        for (PromotionPmType pmType : PromotionPmType.values()) {
            if (promotionPmTypeStr.equals(pmType.toString())) {
                return pmType.promotionPmTypekey;
            }
        }
        return 0;
    }
}
