package com.zianedu.lms.vo;

import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TMileageIssueVO {

    private int pointKey;

    private int userKey;

    private int point;

    private int descType;

    private int jKey;

    private int type;

    private String indate;

    private String jId;

    private String description;

    public TMileageIssueVO(){}

    public TMileageIssueVO(int userKey, int typeSelect, int point, String memo, int jKey, String jId, int descType) {
        this.userKey = userKey;
        this.point = point;
        this.indate = Util.returnNowDateByYYMMDD();
        this.type = typeSelect;
        this.description = memo;
        this.jKey = jKey;
        this.jId = jId;
        this.descType=descType;
    }

}
