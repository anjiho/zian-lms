package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class LecturePauseRecDTO {

    private String logType;

    private String createDate;

    private int pauseTotalDay;

    private int pauseCnt;
}
