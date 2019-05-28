package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class QnaListDTO {

    private int bbsKey;

    private int bbsMasterKey;

    private String indate;

    private String title;

    private int writeUserKey;

    private int readCount;

    private int level;

    private String userId;

    private String userName;

    private boolean isNew;

    private int commentCount;

    private int teacherKey;

    private int ctgKey;
}
