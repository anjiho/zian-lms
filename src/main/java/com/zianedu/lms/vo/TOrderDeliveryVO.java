package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TOrderDeliveryVO {
    private int jDeliveryKey;

    private int jKey;
    //택배회사 키값
    private int deliveryMasterKey;
    //배송상태
    private int status;
    //배송시작일
    private String deliveryStartDate;
    //배송종료일
    private String deliveryEndDate;
    //송장번호
    private String deliveryNo;

    public TOrderDeliveryVO(){}

    public TOrderDeliveryVO(int jKey, int status, int deliveryMasterKey, String deliveryNo) {
        this.jKey = jKey;
        this.deliveryMasterKey = deliveryMasterKey;
        this.status = status;
        this.deliveryStartDate = Util.returnNow();
        this.deliveryNo = deliveryNo;
    }

    public TOrderDeliveryVO(int jDeliveryKey, int jKey, int status, int deliveryMasterKey, String deliveryNo) {
        this.jDeliveryKey = jDeliveryKey;
        this.jKey = jKey;
        this.deliveryMasterKey = deliveryMasterKey;
        this.status = status;
        this.deliveryStartDate = Util.returnNow();
        this.deliveryNo = deliveryNo;
    }
}
