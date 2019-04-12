package com.zianedu.lms.define.datasource;

public enum GoodsType {
    //동영상(온라인강좌)
    VIDEO(1),
    //학원
    ACADEMY(2),
    //책
    BOOK(3);

    int goodsTypeKey;

    GoodsType(int goodsTypeKey) {
        this.goodsTypeKey = goodsTypeKey;
    }

    public static Integer getGoodsTypeKey(String goodsTypeStr) {
        for (GoodsType goodsType : GoodsType.values()) {
            if (goodsTypeStr.equals(goodsType.toString())) {
                return goodsType.goodsTypeKey;
            }
        }
        return null;
    }

}
