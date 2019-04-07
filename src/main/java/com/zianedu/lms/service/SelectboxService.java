package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.SearchKeywordType;
import com.zianedu.lms.mapper.SelectboxMapper;
import com.zianedu.lms.vo.SearchKeywordDomainVO;
import com.zianedu.lms.vo.TSiteVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SelectboxService {

    @Autowired
    private SelectboxMapper selectboxMapper;

    /**
     * 서브도메인 목록 가져오기
     * @return
     */
    @Transactional(readOnly = true)
    public List<TSiteVO> getSubDomainList() {
        return selectboxMapper.selectSubDomainList();
    }

    /**
     * 검색어 도메인 목록 가져오기
     * @return
     */
    public List<SearchKeywordDomainVO> getSearchKeywordDomainList() {
        return SearchKeywordType.getSearchKeywordDomainList();
    }

}
