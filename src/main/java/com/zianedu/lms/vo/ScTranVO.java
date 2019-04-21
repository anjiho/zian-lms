package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class ScTranVO {

    private int trNum;

    private String trSenddate;

    private String trId;

    private String trSendstat;

    private String trRsltstat;

    private String trMsgtype;

    private String trPhone;

    private String trCallback;

    private String trRsltdate;

    private String trModified;

    private String trMsg;

    private String trNet;

    private String trEtc1;

    private String trEtc2;

    private String trEtc3;

    private String trEtc4;

    private String trEtc5;

    private String trEtc6;

    private String trRealsenddate;

    private String trRouteid;

    public ScTranVO() {}

    public ScTranVO(String receiverPhoneNumber, String sendNumber, String msg, String userKey, String userName, String userId) {
        this.trSenddate = Util.returnNow();
        this.trId = "";
        this.trSendstat = String.valueOf(0);
        this.trSendstat = "";
        this.trMsgtype = String.valueOf(0);
        this.trPhone = receiverPhoneNumber;
        this.trCallback = sendNumber;
        this.trRsltdate = "";
        this.trModified = "";
        this.trMsg = msg;
        this.trNet = "";
        this.trEtc1 = String.valueOf(0);
        this.trEtc2 = userKey;
        this.trEtc3 = Util.isNullValue(userName, "");
        this.trEtc4 = Util.isNullValue(userId, "");
        this.trEtc5 = "";
        this.trEtc6 = "";
        this.trRealsenddate = "";
        this.trRouteid = "";

    }
}
