package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class AdminCouponListDTO {

    private String userId;

    private String userKey;

    private String name;

    private String indate;

    private String startDate;

    private String valIdDate;

    private String description;

    private int limitDay;
}
