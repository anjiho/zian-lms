package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Aes256;
import com.zianedu.lms.utils.SecurityUtil;
import com.zianedu.lms.utils.Util;
import lombok.Data;

import java.io.Serializable;

@Data
public class TUserVO implements Serializable {

    private int userKey;

    private Long cKey;
    //아이디
    private String userId;
    //등록일
    private String indate;
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

    private String zipcode;

    private String addressRoad;

    private String addressNumber;

    private String address;

    private String email;

    private String snsFacebook;

    private String snsTwiter;

    private String snsGoogleplus;

    private String recvSms;

    private String recvEmail;

    private String recvSnsFacebook;

    private String recvSnsTwiter;

    private String recvSnsGoogleplus;
    //복지 할인률
    private int welfareDcPercent;

    private String certCode;

    private int grade;
    //직렬 카테고리 키
    private int interestCtgKey0;

    private int interestCtgKey1;

    private int isMobileReg;

    private int adminAuthorityKey;
    //등급변경일
    private String gradeDate;

    private int gradeGKey;

    private int gradePrice;

    private String note;

    private String appPushKey;

    private String appDeviceType;

    private String userPwd;

    public TUserVO() {}

    public TUserVO(int userKey, String userName, int authority) {
        this.userKey = userKey;
        this.name = userName;
        this.authority = authority;
    }

    public TUserVO(TUserVO tUserVO) throws Exception {
        this.userId = tUserVO.getUserId();
        this.inDate = tUserVO.getInDate();
        this.name = tUserVO.getName();
        this.authority = tUserVO.getAuthority();
        this.pwd = SecurityUtil.encryptSHA256(tUserVO.getPwd());
        this.birth = Util.isNullValue(tUserVO.getBirth(), "");
        this.lunar = tUserVO.getLunar();
        this.gender = tUserVO.getGender();
        this.telephone = Util.isNullValue(Aes256.encrypt(tUserVO.getTelephone()), "");
        this.telephoneMobile = Util.isNullValue(Aes256.encrypt(tUserVO.getTelephoneMobile()), "");
        this.zipCode = Util.isNullValue(tUserVO.getZipCode(), "");
        this.address = Util.isNullValue(tUserVO.getAddress(), "");
        this.email = Util.isNullValue(Aes256.encrypt(tUserVO.getEmail()), "");
        this.recvSms = tUserVO.getRecvSms();
        this.recvEmail = tUserVO.getRecvEmail();
        this.grade = tUserVO.getGrade();
        this.interestCtgKey0 = tUserVO.getInterestCtgKey0();
        this.adminAuthorityKey = tUserVO.getAdminAuthorityKey();
        this.isMobileReg = tUserVO.getIsMobileReg();
        this.gradePrice = tUserVO.getGradePrice();
        this.note = Util.isNullValue(tUserVO.getNote(), "");
    }
}
