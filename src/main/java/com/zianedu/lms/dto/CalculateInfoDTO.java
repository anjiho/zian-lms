package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class CalculateInfoDTO {

    private int gKey;

    private String name;

    private Long jKey;

    private int type;

    private int kind;

    private int price;

    private int couponDcPrice;

    private int dcWelfare;

    private int dcPoint;

    private int dcFree;

    private int calcCalculateRate;

    private int gCalculateRate;

    private int gTCalculateRate;

    private int tCalculateRate;

    private int jGCount;

    private float payCharge;

    private int pmType;

    private int payStatus;

}
