package com.zianedu.lms.define.datasource;

public enum TLectureStatusType {

    PROGRESS(0, "처리중"),
    PROCEED(1, "진행중"),
    COMPLETE(2, "완료")
    ;

    int status;

    String statusStr;

    TLectureStatusType(int status, String statusStr) {
        this.status = status;
        this.statusStr = statusStr;
    }

    public static String getStatusStr(int status) {
        for (TLectureStatusType statusType : TLectureStatusType.values()) {
            if (statusType.status == status) {
                return statusType.statusStr;
            }
        }
        return null;
    }
}
