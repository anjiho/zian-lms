package com.zianedu.lms.dto;

import lombok.Data;

import java.util.List;

@Data
public class QnaDetailInfoDTO {

    private QnaListDTO qnaDetailInfo;

    private List<BbsCommentDTO> commentList;

    public QnaDetailInfoDTO() {}

    public QnaDetailInfoDTO(QnaListDTO qnaDetailInfo, List<BbsCommentDTO> commentList) {
        this.qnaDetailInfo = qnaDetailInfo;
        this.commentList = commentList;
    }
}
