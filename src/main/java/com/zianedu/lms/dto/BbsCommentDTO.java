package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class BbsCommentDTO {

    private int bbsCommentKey;

    private String userName;

    private String commentContents;

    private String indate;

}
