package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import com.zianedu.lms.utils.Util;
import lombok.Data;

@Data
public class TMemoVO {

    private int memoKey;

    private int cKey;

    private String tableName;

    private int tableKey;

    private int sendUserKey;

    private String indate;

    private String title;

    private String memo;

    public TMemoVO(){}

    public TMemoVO(int tableKey, int sendUserKey, String title, String memo) {
        this.cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
        this.tableName = "t_order";
        this.tableKey = tableKey;
        this.sendUserKey = sendUserKey;
        this.indate = Util.returnNow();
        this.title = title;
        this.memo = memo;
    }

}
