package com.zianedu.lms.vo;

import lombok.Data;

import java.util.Date;

@Data
public class TBbsVO {

    private int bbsKey;

    private int bbsMasterKey;

    private String indate;

    private String title;

    private int writeUserKey;

    private int isNotice;

    private String contents;

    private String filename;

}
