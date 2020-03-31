package com.zianedu.lms.service;

import com.zianedu.lms.define.datasource.DataSource;
import com.zianedu.lms.define.datasource.DataSourceType;
import com.zianedu.lms.mapper.TestMapper;
import com.zianedu.lms.repository.TeacherCalculateRepository;
import com.zianedu.lms.utils.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
public class ScheduleService {

    static final Logger logger = LoggerFactory.getLogger(ScheduleService.class);

    @Autowired
    private TeacherCalculateRepository teacherCalculateRepository;

    @Autowired
    private TestMapper testMapper;

    /**
     * 강사 정산 스케쥴링
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public void calculateTeacherSaleGoods() throws Exception {
        String yyyymmdd = Util.plusDate(Util.returnNow(), -1);
        teacherCalculateRepository.calculateTeacherSaleGoodsAny(yyyymmdd);
    }
}
