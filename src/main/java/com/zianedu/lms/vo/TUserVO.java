package com.zianedu.lms.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class TUserVO implements Serializable {

    private Long userKey;

    private Long cKey;

    private String userId;

    private String inDate;

    private String name;

    private int authority;

    private int status;

    private String pwd;

    private String birth;

    private String lunar;

    private String gender;

    private String telephone;

    private String telephoneMobile;

    private String zipCode;

    private String addressRoad;

    private String addressNumber;

    private String address;

    private String email;

    private String snsFacebook;

    private String snsTwiter;

    private String snsGoogleplus;

    private String recvSms;

    private String recvSnsFacebook;

    private String recvSnsTwiter;

    private String recvSnsGoogleplus;

    private int welfareDcPercent;

    private String certCode;

    private int grade;

    private int interestCtgKey0;

    private int interestCtgKey1;

    private int isMobileReg;

    private int adminAuthorityKey;

    private String gradeDate;

    private int gradeGKey;

    private int gradePrice;

    private String note;

    private String appPushKey;

    private String appDeviceType;

    public TUserVO() {}

    public TUserVO(Long userKey, String userName, int authority) {
        this.userKey = userKey;
        this.name = userName;
        this.authority = authority;
    }

}
