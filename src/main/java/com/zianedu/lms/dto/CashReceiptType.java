package com.zianedu.lms.dto;

public enum CashReceiptType {

    NONE(0, "신청안함"),
    SOCIAL_NUMBER(1, "주민번호"),
    PHONE_NUMBER(2, "핸드폰번호"),
    BUSINESS_NUMBER(3, "사업자번호");

    int cashReceiptTypeKey;

    String cashReceiptTypeStr;

    CashReceiptType(int cashReceiptTypeKey, String cashReceiptTypeStr) {
        this.cashReceiptTypeKey = cashReceiptTypeKey;
        this.cashReceiptTypeStr = cashReceiptTypeStr;
    }

    public static String getCashReceiptTypeStr(int cashReceiptTypeKey) {
        for (CashReceiptType cashReceiptType : CashReceiptType.values()) {
            if (cashReceiptType.cashReceiptTypeKey == cashReceiptTypeKey) {
                return cashReceiptType.cashReceiptTypeStr;
            }
        }
        return null;
    }
}
