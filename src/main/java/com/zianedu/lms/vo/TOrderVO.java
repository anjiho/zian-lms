package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.utils.Util;
import com.zianedu.lms.utils.ZianUtils;
import lombok.Data;

@Data
public class TOrderVO {

    private int jKey;

    private int cKey;

    private int userKey;

    private String jId = "";

    private String indate = "";

    private int price;

    private int pricePay;

    private int point;

    private int dcWelfare;

    private int dcPoint;

    private int dcCoupon;

    private int dcFree;

    private int deliveryPrice;

    private int payStatus;

    private String payDate;

    private int payType;

    private String cancelDate;

    private String bank;

    private String bankAccount;

    private String cardCode;

    private String depositUser;

    private String depositDate;

    private String deliveryName;

    private String deliveryTelephone;

    private String deliveryTelephoneMobile;

    private String deliveryEmail;

    private String deliveryZipcode;

    private String deliveryAddress;

    private String deliveryAddressRoad;

    private String deliveryAddressAdd;

    private String uniqueTypeList;

    private String uniqueExtendDayList;

    private int payKey;

    private int offlineSerial;

    private int isMobile;

    private int isOffline;

    private int tmp;

    private String gNameList;

    private int isCancelRequest;

    private int cashReceiptType;

    private String cashReceiptNumber;

    private String cancelRequestDate;

    public TOrderVO() {}

    public TOrderVO(int userKey, int price, int payType, String cardCode,String cashReceiptNumber,int cashReceiptType) {
        this.cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
        this.userKey = userKey;
        this.jId = ZianUtils.getJId();
        this.indate = Util.returnNow();
        this.price = price;
        this.pricePay = price;
        this.point = 0;
        this.dcWelfare = 0;
        this.dcPoint = 0;
        this.dcCoupon = 0;
        this.dcFree = 0;
        this.deliveryPrice = 0;
        this.payStatus = 2;
        this.payDate = Util.returnNow();
        this.payType = payType;
        this.cancelDate = "";
        this.bank = "";
        this.bankAccount = "";
        this.cardCode = cardCode;
        this.depositUser = "";
        this.depositDate = "";
        this.deliveryName = "";
        this.deliveryTelephone = "";
        this.deliveryTelephoneMobile = "";
        this.deliveryEmail = "";
        this.deliveryZipcode = "";
        this.deliveryAddress = "";
        this.deliveryAddressRoad = "";
        this.deliveryAddressAdd = "";
        this.uniqueTypeList = "2,";
        this.uniqueExtendDayList = "-1,";
        this.payKey = 0;
        this.offlineSerial = 0;
        this.isMobile = 0;
        this.isOffline = 1;
        this.tmp = 0;
        this.gNameList = "";
        this.isCancelRequest = 0;
        this.cashReceiptType = cashReceiptType;
        this.cashReceiptNumber = cashReceiptNumber;
        this.cancelRequestDate = "";
    }
}
