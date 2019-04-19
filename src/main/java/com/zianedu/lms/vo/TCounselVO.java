package com.zianedu.lms.vo;

import com.zianedu.lms.session.UserSession;
import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCounselVO {

    private int counselKey;

    private int cKey;

    private int userKey;

    private int writeUserKey;

    private int type;

    private int status;

    private String indate;

    private String procStartDate;

    private String procEndDate;

    private String telephone;

    private String telephoneMobile;

    private String memo;

    private String contents;

    private String imageFile1;

    private String imageFile2;

    private String imageFile3;

    private String imageFile4;

    private String imageFile5;

    public TCounselVO(){}

    public TCounselVO(TCounselVO tCounselVO) {
        this.userKey = tCounselVO.getUserKey();
        this.writeUserKey = UserSession.get() == null ? 5 : UserSession.getUserKey();
        this.type = tCounselVO.getType();
        this.status = tCounselVO.getStatus();
        this.indate = Util.returnNow();
        this.procStartDate = tCounselVO.getProcStartDate();
        this.procEndDate = tCounselVO.getProcEndDate();
        this.telephone = tCounselVO.getTelephone();
        this.telephoneMobile = tCounselVO.getTelephoneMobile();
        this.memo = Util.isNullValue(tCounselVO.getMemo(), "");
        this.contents = Util.isNullValue(tCounselVO.getContents(), "");
    }
}
