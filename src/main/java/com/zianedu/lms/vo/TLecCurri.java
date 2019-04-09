package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TLecCurri {

    private int curriKey;

    private int lecKey;

    private String name;

    private String vodFileLow;

    private String vodFileHigh;

    private String vodFileMobileLow;

    private String vodFileMobileHigh;

    private int vodTime;

    private String dataFile;

    private int dataPage;

    private int isShow;

    private int isSample;

    private int unitCtgKey;

    private int pos;

    private int tmp;
}
