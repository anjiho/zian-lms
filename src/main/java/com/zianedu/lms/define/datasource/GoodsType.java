package com.zianedu.lms.define.datasource;

public enum GoodsType {
    //동영상(온라인강좌)
    VIDEO(1, "온라인강좌"),
    //학원
    ACADEMY(2, "학원강의"),
    //책
    BOOK(3, "도서"),
    //모의고사
    EXAM(4, "모의고사")
    ;

    int goodsTypeKey;

    String goodsTypeStr;

    GoodsType(int goodsTypeKey, String goodsTypeStr) {
        this.goodsTypeKey = goodsTypeKey;
        this.goodsTypeStr = goodsTypeStr;
    }

    public static Integer getGoodsTypeKey(String goodsTypeStr) {
        for (GoodsType goodsType : GoodsType.values()) {
            if (goodsTypeStr.equals(goodsType.toString())) {
                return goodsType.goodsTypeKey;
            }
        }
        return null;
    }

    public static String getGoodsTypeStr(int goodsTypeKey) {
        for (GoodsType goodsType : GoodsType.values()) {
            if (goodsTypeKey == goodsType.goodsTypeKey) {
                return goodsType.goodsTypeStr;
            }
        }
        return null;
    }

}
