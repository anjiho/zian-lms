package com.zianedu.lms.vo;

import com.zianedu.lms.session.UserSession;
import lombok.Data;

@Data
public class TBbsCommentVO {

    private int bbsCommentKey;

    private int bbsKey;

    private int userKey;

    private String indate;

    private String comment_;

    public TBbsCommentVO() {}

    public TBbsCommentVO(int bbsKey, String commentContents) {
        this.bbsKey = bbsKey;
        this.userKey = UserSession.get() == null ? 5 : UserSession.getUserKey();
        this.comment_ = commentContents;
    }
}
