package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TLecVO {

    private int lecKey;

    private int gKey;

    private int teacherKey;

    private int classGroupCtgKey;

    private int subjectCtgKey;

    private int stepCtgKey;

    private int status;

    private String regdate;

    private String startdate;

    private int limitDay;

    private int limitCount;

    private int lecTime;

    private float multiple;

    private int lecDateYear;

    private int lecDateMonth;

    private int examYear;

    private int isPack;

    private int goodsId;

}
