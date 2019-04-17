package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import lombok.Data;

@Data
public class TCouponMasterVO {

    private int couponMasterKey;

    private int cKey = ZianCoreManage.ZIAN_COMPANY_CODE;

    private String indate;

    private int type;

    private String name;

    private int dcType;

    private int dcValue;

    private String contents;

    private int targetType;

    private int periodType;

    private int limitDay;

    private String startDate;

    private String endDate;

    private int limitPriceMin;

    private int isShow;

    private int device;
}
