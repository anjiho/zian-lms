package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import lombok.Data;

@Data
public class TCouponMasterVO {

    private Integer couponMasterKey;

    private int cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
    //등록일
    private String indate;
    //지급방식
    private int type;
    //이름
    private String name;
    //할인설정
    private int dcType;
    //할인값
    private int dcValue;
    //쿠폰설명
    private String contents;

    private int targetType = 1;
    //사용기간
    private int periodType;
    //발행일 기준일때 일수제한
    private int limitDay;
    // 지정기간일때 시작일
    private String startDate;
    // 지정기간일때 종료일
    private String endDate;
    // 쿠폰 사용 제한
    private int limitPriceMin;
    // 노출여부
    private int isShow;
    // 사용가능 디바이스
    private int device;
}
