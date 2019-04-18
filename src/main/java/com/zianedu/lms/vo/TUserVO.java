package com.zianedu.lms.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class TUserVO implements Serializable {

    private Long userKey;

    private Long cKey;
    //아이디
    private String userId;
    //등록일
    private String inDate;
    //이름
    private String name;
    //권한
    private int authority;
    //가입상태 0 - 가입대기, 1 - 오프라인에서 가입후 대기중, 10 - 회원가입된 상태, 20 - 탈퇴대기, 21 - 탈퇴완료
    private int status;
    //비밀번호
    private String pwd;
    //생년월일
    private String birth;
    //음력
    private String lunar;
    //성별
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
