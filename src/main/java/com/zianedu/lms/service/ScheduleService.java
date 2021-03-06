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

    @DataSource(DataSourceType.GW_ORACLE)
    public void daySchedule() throws Exception {
        List<HashMap<String, Object>>list = testMapper.selectMyTable();
        this.insertBrdWork(list);

    }

    @DataSource(DataSourceType.GW_ORACLE)
    public void insertBrdWork(List<HashMap<String, Object>>list) {
        for (HashMap<String, Object> listMap : list) {
            String userId = String.valueOf(listMap.get("USER_ID"));

            String userName = "";
            String title = "";
            String email = "";
            if (userId.equals("10062")) {
                userName = "안지호";
                title = "업무일지_안지호";
                email = "anjo0070@zianedu.com";
            } else if (userId.equals("10063")) {
                userName = "원은정";
                title = "업무일지_원은정";
                email = "ejwon@zianedu.com";
            }

            int idx = testMapper.selectWorkCurrentIdx();
            HashMap<String, Object> paramMap = new HashMap<>();
            paramMap.put("idx", idx + 1);
            paramMap.put("userId", listMap.get("USER_ID"));
            paramMap.put("name", userName);
            paramMap.put("email", email);
            paramMap.put("title", title);
            paramMap.put("contents", listMap.get("CONTENT"));

            testMapper.insertBrdWork(paramMap);
        }
    }

}
