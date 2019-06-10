package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class LectureTimeInfoDTO {

    private Long jLecKey;

    private String jId;

    private int userKey;

    private String name;

    private String goodsName;

    private int kind;

    private int status;

    private String startDt;

    private String endDt;

    private int limitDay;
}
