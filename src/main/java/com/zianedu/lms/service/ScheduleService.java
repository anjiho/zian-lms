package com.zianedu.lms.service;

import com.zianedu.lms.repository.TeacherCalculateRepository;
import com.zianedu.lms.utils.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScheduleService {

    static final Logger logger = LoggerFactory.getLogger(ScheduleService.class);

    @Autowired
    private TeacherCalculateRepository teacherCalculateRepository;

    /**
     * 강사 정산 스케쥴링
     * @throws Exception
     */
    public void calculateTeacherSaleGoods() throws Exception {
        String yyyymmdd = Util.plusDate(Util.returnNow(), -1);
        teacherCalculateRepository.calculateTeacherSaleGoodsAny(yyyymmdd);
    }

}
