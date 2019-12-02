package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class LectureTimeDTO {

    private Long curriKey;

    private String name;

    private int vodTime;

    private int remainTime;

    private Long jCurriKey;

    private int vodTotalTime;

    private int remainTotalTime;
}
