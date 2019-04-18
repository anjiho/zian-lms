package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class OfflineCouponListDTO {
    //쿠폰번호
    private String code;
    //생성일자
    private String produceDate;
    //발급일자
    private String issueDate;

    private String userId;

    private String jId;

    private String name;

    private String startDate;

    private String endDate;
}
