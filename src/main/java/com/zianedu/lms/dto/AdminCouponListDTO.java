package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class AdminCouponListDTO {

    private String userId;

    private String userKey;

    private String name;

    private String indate;

    private String indate2;

    private String startDate;

    private String endDate;

    private String valIdDate;

    private String useDate;

    private String description;

    private String code;

    private int limitDay;

    private int couponMasterKey;
}
