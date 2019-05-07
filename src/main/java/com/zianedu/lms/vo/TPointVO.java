package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TPointVO {

    private int pointKey;

    private int cKey;

    private String indate;

    private int userKey;

    private int type;

    private int point;

    private int jKey;

    private String jId;

    private int descType;

    private String description;

    public TPointVO() {}

    public TPointVO(int userKey, int point, String description) {
        this.cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
        this.indate = Util.returnNow();
        this.userKey = userKey;
        this.type = 0;
        this.point = point;
        this.jKey = 0;
        this.jId = "";
        this.descType = 0;
        this.description = Util.isNullValue(description, "");
    }
}
