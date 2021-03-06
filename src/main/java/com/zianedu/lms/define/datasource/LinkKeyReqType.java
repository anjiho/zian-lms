package com.zianedu.lms.define.datasource;

public enum LinkKeyReqType {
    //포함된 온라인강좌
    ONLINE_LECTURE(1),
    //사은품
    GIFT(4),
    //강의교재
    LECTURE_BOOK(5),
    //연계강좌
    LECTURE_REL(6),
    //전벙위 모의고사
    LEC_ALL_RANGE_EXAM(8),
    //기출문제 회차별
    LEC_OUTFLOW_TURN(9),
    //쿠폰
    COUPON(100),
    //팝업
    POPUP(100),
    ;

    int linkKeyReq;

    LinkKeyReqType(int linkKeyReq) {
        this.linkKeyReq = linkKeyReq;
    }
}
