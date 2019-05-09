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

    public TCalculateOptionVO(int teacherKey, String targetDate, String title, int price) {
        this.teacherKey = teacherKey;
        this.targetDate = targetDate;
        this.title = Util.isNullValue(title, "");
        this.price = price;
    }
}
