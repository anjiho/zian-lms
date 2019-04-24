package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCategoryOtherInfoVO {

    private int ctgInfoKey;//테이블키값

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

    public TCategoryOtherInfoVO() {}

    public TCategoryOtherInfoVO(int ctgKey, String value1, String value3,
                                String value4, String value5, int valueBit1, int pos) {
        this.ctgKey = ctgKey;
        this.value1 = Util.isNullValue(value1, "");
        this.value3 = value3;
        this.value4 = value4;
        this.value5 = value5;
        this.valueBit1 = valueBit1;
        this.pos = pos;
    }
}
