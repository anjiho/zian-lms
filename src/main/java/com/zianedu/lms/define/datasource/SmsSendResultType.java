package com.zianedu.lms.define.datasource;

/**
 * SMS 발송 결과 타입 정의 TR_RSLTSTAT
 */
public enum SmsSendResultType {

    SUCCESS("06", "성공"),
    DISJUNCTION("07", "결번"),
    ETC("28", "실패");

    String sendResultKey;

    String sendResultStr;

    SmsSendResultType(String sendResultKey, String sendResultStr) {
        this.sendResultKey = sendResultKey;
        this.sendResultStr = sendResultStr;
    }

    public static String getSmsSendResultStr(String sendResultKey) {
        for (SmsSendResultType resultType : SmsSendResultType.values()) {
            if (sendResultKey.equals(resultType.sendResultKey)) {
                return resultType.sendResultStr;
            }
        }
        return null;
    }

}
