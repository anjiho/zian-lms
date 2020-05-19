package com.zianedu.lms.dto;

/**
 * 회원권한 정의
 */
public enum MileageDescType {
    DESCTYPE1(1, "상품구매"),
    DESCTYPE2(2, "상품구매"),
    DESCTYPE3(3, "상품구매 주문취소"),
    DESCTYPE4(4, "결제취소"),
    DESCTYPE5(5, "결제취소");

    int descType;

    String descTypeStr;

    MileageDescType(int descType, String descTypeStr) {
        this.descType = descType;
        this.descTypeStr = descTypeStr;
    }

    public static String getMileageDescTypeStr(int descType,String jId) {
        for (MileageDescType authorityType : MileageDescType.values()) {
            if (descType == authorityType.descType) {
                if (descType == 1) {
                    return authorityType.descTypeStr + "(" + jId + ")에 의한 마일리지 획득";
                } else if (descType == 2) {
                    return authorityType.descTypeStr + "(" + jId + ")에 의한 마일리지 사용";
                } else if (descType == 3) {
                    return authorityType.descTypeStr + "(" + jId + ")로 인해 사용한 마일리지 반환";
                } else if (descType == 4) {
                    return authorityType.descTypeStr + "(" + jId + ")로 인해 사용한 마일리지 반환";
                } else if (descType == 5) {
                    return authorityType.descTypeStr + "(" + jId + ")로 인해 획득한 마일리지 반환";
                }
            }
        }
        return null;
    }
}
