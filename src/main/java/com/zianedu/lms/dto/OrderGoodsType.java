package com.zianedu.lms.dto;

import com.zianedu.lms.define.datasource.GoodsType;

public enum OrderGoodsType {
    //동영상(온라인강좌)
    VIDEO(1, "온라인강좌"),
    //학원
    ACADEMY(2, "학원강의"),
    //책
    BOOK(3, "도서"),
    //모의고사
    EXAM(4, "모의고사"),
    //패키지
    PACKAGE(5, "프로모션")
    ;

    int goodsTypeKey;

    String goodsTypeStr;

    OrderGoodsType(int goodsTypeKey, String goodsTypeStr) {
        this.goodsTypeKey = goodsTypeKey;
        this.goodsTypeStr = goodsTypeStr;
    }

    public static String getGoodsTypeStr(int goodsTypeKey) {
        for (OrderGoodsType orderGoodsType : OrderGoodsType.values()) {
            if (goodsTypeKey == orderGoodsType.goodsTypeKey) {
                return orderGoodsType.goodsTypeStr;
            }
        }
        return null;
    }
}
