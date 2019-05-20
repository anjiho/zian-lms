package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class OrderDetailInfoDTO {
    //주문번호
    private String jId;

    private int userKey;

    private int payStatus;

    private int payType;
    //주문금액
    private int price;
    //결제금액
    private int pricePay;
    //배송비
    private int deliveryPrice;
    //결제일
    private String payDate;
    //복지할인
    private int dcWelfare;
    //쿠폰할인
    private int dcCoupon;
    //사용마일리지
    private int dcPoint;
    //적립 마일리지
    private int point;
    //남은 마일리지
    private int remainPoint;
    //은행명
    private String bank;
    //계좌번호
    private String bankAccount;
    //입금예정자 이름
    private String depositUser;
    //입금 예정일
    private String depositDate;
    //취소일
    private String cancelDate;
    //현금영수증 타입
    private int cashReceiptType;
    //현금영주증 번호
    private String cashReceiptNumber;

    private String payStatusName;

    private String payTypeName;

    private String cashReceiptTypeName;

    private String pgMsg;
}
