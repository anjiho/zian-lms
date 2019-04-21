package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class SmsSendListDTO {

    private String sendDate;

    private String receiveNumber;

    private String sendNumber;

    private String receiverName;

    private String receiverId;

    private String sendResult;

    private String sendResultName;

    private String sendMessage;

    private int userKey;
}
