package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class CouponListDTO {

    private int couponMasterKey;

    private int type;

    private String name;

    private int dcType;

    private int dcValue;

    private String issueDate;

    private String dateUse;

    private String issueTypeName;

    private String dcTypeName;

    private String description;

    private int limitDay;

    private int periodType;

    private String periodTypeName;

    private String searchType;

    private String searchText;
}
