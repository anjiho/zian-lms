package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TGoodsVO {

    private int gKey;

    private int cKey;

    private int cpKey;

    private String name;

    private String indate;

    private String sellstartdate;

    private int type;

    private int isShow;

    private int isSell;

    private int isFree;

    private int isNodc;

    private String imageList;

    private String imageView;

    private int emphasis;

    private String tags;

    private String summary;

    private String description;

    private int calculateRate;

    private int isFreebieDeliveryFree;

    private int isQuickDelivery;

    private int goodsId;
}
