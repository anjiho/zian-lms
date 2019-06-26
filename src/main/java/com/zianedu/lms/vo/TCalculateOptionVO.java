package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCalculateOptionVO {

    private int calculateOptionKey;

    private int teacherKey;

    private String targetDate;

    private String title;

    private int price;

    public TCalculateOptionVO(){}

    public TCalculateOptionVO(int teacherKey, String title, int price, String yyyymm) {
        this.teacherKey = teacherKey;
        this.title = Util.isNullValue(title, "");
        this.price = price;
        this.targetDate = yyyymm + "-01 00:00:00";
    }
}
