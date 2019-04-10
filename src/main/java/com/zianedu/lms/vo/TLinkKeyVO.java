package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TLinkKeyVO {

    private int linkKey;

    private int reqKey;

    private int resKey;

    private int reqType;

    private int resType;

    private int pos;
    //주교재 여부
    private Object valueBit;

    private String goodsName;
}
