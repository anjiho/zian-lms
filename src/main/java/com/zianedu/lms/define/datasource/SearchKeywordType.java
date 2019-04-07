package com.zianedu.lms.define.datasource;

import com.zianedu.lms.vo.SearchKeywordDomainVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public enum SearchKeywordType {

    PUBLIC("행정직"),
    TECH("기술직"),
    POST("계리직"),
    BOOK("온라인 서점");

    String domainKorName;

    SearchKeywordType(String domainKorName) {
        this.domainKorName = domainKorName;
    }

    public static List<SearchKeywordDomainVO> getSearchKeywordDomainList() {
        List<SearchKeywordDomainVO>domainList = new ArrayList<>();
        for (SearchKeywordType keywordType : SearchKeywordType.values()) {
            SearchKeywordDomainVO domainVO = new SearchKeywordDomainVO(
                    keywordType.toString(), keywordType.domainKorName
            );
            domainList.add(domainVO);
        }
        return domainList;
    }
}
