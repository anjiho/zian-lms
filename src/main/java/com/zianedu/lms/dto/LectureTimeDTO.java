package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class LectureTimeDTO {

    private int curriKey;

    private String name;

    private int vodTime;

    private int remainTime;
}
