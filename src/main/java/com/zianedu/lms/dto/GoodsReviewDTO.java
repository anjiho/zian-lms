package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class GoodsReviewDTO {

    private int gReviewKey;

    private String title;

    private int point;

    private String name;

    private String indate;

    private String contents;
}
