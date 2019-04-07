package com.zianedu.lms.vo;

import lombok.Data;

@Data
public class SearchKeywordDomainVO {

    private String className;

    private String domainName;

    public SearchKeywordDomainVO() {}

    public SearchKeywordDomainVO(String className, String domainName) {
        this.className = className;
        this.domainName = domainName;
    }
}
