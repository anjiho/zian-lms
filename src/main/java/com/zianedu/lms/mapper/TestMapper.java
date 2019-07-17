package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.TBbsVO;

import java.util.HashMap;
import java.util.List;

public interface TestMapper {

    List<TBbsVO> selectNotice();

    Integer selectWorkCurrentIdx();

    List<HashMap<String, Object>> selectMyTable();

    void insertBrdWork(HashMap<String, Object>paramMap);
}
