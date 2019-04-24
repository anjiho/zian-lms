package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class TBookVO {

    private int bookKey;

    private int gKey;

    private int status;

    private String writer;

    private String publishDate;

    private int pageCnt;

    private String isbn;

    private int isDeliveryFree;

    private int isSet;

    private String contentList;

    private int subjectCtgKey;

    private int classGroupCtgKey;

    private int goodsId;
    //과년도 도서키(g_key)
    private int nextGKey;
    //급수명
    private String classGroupName;
    //과목명
    private String subjectName;
    //출판사키
    private int cpKey;
    //출판사명
    private String cpName;
}
