package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TResVO {

    private int resKey;//0

    private int type;//0

    private int device;//pc 1, mobile 3
    //파일명
    private int key00;//techerkey

    private int key01;

    private int key02;//카테고리 키값

    private int key00Type;

    private int key01Type;

    private int key02Type;

    private String value;

    private String valueText;//내용

    private String ctgName;
}
