package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TCalculateVO {

    private Long calculateKey;

    private int cKey;

    private int teacherKey;

    private String indate;

    private String targetDate;

    private String yearMonth;

    public TCalculateVO(){}

    public TCalculateVO(int teacherKey) throws Exception {
        this.cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
        this.teacherKey = teacherKey;
        this.indate = Util.returnNow();
        this.targetDate = Util.plusDate(Util.returnNow(), -1);
        this.yearMonth = Util.convertDateFormat2(Util.plusDate(Util.returnNow(), -1));
    }
}
