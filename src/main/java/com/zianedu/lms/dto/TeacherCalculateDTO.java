package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class TeacherCalculateDTO implements GoodsKindNameContain {

    private int gKey;

    private int kind;

    private String name;

    private int payCnt;

    private Long payPrice;

    private int cancelCnt;

    private Long cancelPrice;

    private String kindName;

    @Override
    public Integer goodsKind() {
        return kind;
    }

    @Override
    public void addGoodsKindName(GoodsKindName goodsKindName) {
        kindName = goodsKindName.getGoodsKindName();
    }
}
