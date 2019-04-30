package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class OrderResultDTO {

    private String jId;

    private Long jKey;

    private String name;

    private String userId;

    private Long pricePay;

    private int payType;

    private int payStatus;

    private int isMobile;

    private int deliverStatus;

    private String indate;

    private String orderGoodsName;

    private int orderGoodsCount;

    private String payTypeName;

    private String payStatusName;

    private String depositUser;

    private int cardCode;

    private int isOffline;

    private int userKey;
}
