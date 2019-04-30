package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class OrderLectureListDTO implements GoodsKindNameContain, OrderLecStatusNameContain {

    private Long jLecKey;

    private int kind;

    private String kindName;

    private String goodsName;

    private int status;

    private String statusName;

    private String startDt;

    private String endDt;

    private int limitDay;

    private int pauseCnt;

    private String pauseStartDt;

    private int pauseTotalDay;

    private int pauseDay;

    private String jId;

    @Override
    public Integer goodsKind() {
        return kind;
    }

    @Override
    public void addGoodsKindName(GoodsKindName goodsKindName) {
        kindName = goodsKindName.getGoodsKindName();
    }

    @Override
    public Integer orderLecStatusKey() {
        return status;
    }

    @Override
    public void addOrderLecStatusName(OrderLecStatusName orderLecStatusName) {
        kindName = orderLecStatusName.getOrderLecStatusName();
    }
}
