package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TLinkKeyVO {

    private int linkKey;
    // G_KEY
    private int reqKey;
    // T_GOODS.g_key, T_EXAM_MASTER.exam_key
    private int resKey;

    private int reqType;

    private int resType;

    private int pos;
    //주교재 여부
    private Object valueBit;

    private String goodsName;

    public TLinkKeyVO(){}

    public TLinkKeyVO(int linkKey, int valueBit) {
        this.linkKey = linkKey;
        this.valueBit = valueBit;
    }
}
