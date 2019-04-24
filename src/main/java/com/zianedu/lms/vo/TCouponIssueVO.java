package com.zianedu.lms.vo;

import com.zianedu.lms.utils.DateUtils;
import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCouponIssueVO {

    private int couponIssueKey;

    private int couponMasterKey;

    private int userKey;

    private String indate;

    private int couponOfflineKey;

    private int jGKey;

    private String useDate;

    private String description;

    public TCouponIssueVO(){}

    public TCouponIssueVO(int couponMasterKey, int userKey) {
        this.couponMasterKey = couponMasterKey;
        this.userKey = userKey;
        this.indate = Util.returnNowDateByYYMMDD();
        this.couponOfflineKey = 0;
        this.jGKey = 0;
        this.useDate = "";
        this.description = "관리자 발급";
    }

}
