package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCouponOfflineVO {

    private int couponOfflineKey;

    private int couponMasterKey;

    private String indate;

    private String code;

    private int isIssue;

    public TCouponOfflineVO(){}

    public TCouponOfflineVO(int couponMasterKey, String code) {
        this.couponMasterKey = couponMasterKey;
        this.indate = Util.returnNowDateByYYMMDD();
        this.code = code;
        this.isIssue = 0;
    }
}
