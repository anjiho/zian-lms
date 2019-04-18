package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TUserSecessionVO {

    private int secessionKey;

    private int cKey;

    private int userKey;

    private String userId;

    private String name;

    private String indate;

    private String reason;

    private String memo;

    private String obtainDate;
}
