package com.zianedu.lms.vo;

import com.zianedu.lms.define.datasource.ZianCoreManage;
import lombok.Data;

@Data
public class TSearchKeywordVO {

    private int searchKeywordKey;

    private int cKey;

    private String siteClassName;

    private String keyword;

    private int pos;

    public TSearchKeywordVO() {}

    public TSearchKeywordVO(String siteClassName, String keyword, int pos) {
        this.cKey = ZianCoreManage.ZIAN_COMPANY_CODE;
        this.siteClassName = siteClassName;
        this.keyword = keyword;
        this.pos = pos + 1;
    }
}
