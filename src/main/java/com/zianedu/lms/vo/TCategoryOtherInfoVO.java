package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TCategoryOtherInfoVO {

    private int ctgInfoKey;

    private int ctgKey;

    private int type;
    //이미지 경로
    private String value1;

    private String value2;
    //색상코드
    private String value3;
    //Target Url
    private String value4;
    //타이틀
    private String value5;

    private int valueLong1;

    private int valueLong2;
    //새창에서 열기 여부
    private int valueBit1;

    private int pos;
}
