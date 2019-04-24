package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class SmsSendDTO {

    private String receiverPhoneNumber;

    private String sendNumber;

    private String msg;

    private int userKey;
}
