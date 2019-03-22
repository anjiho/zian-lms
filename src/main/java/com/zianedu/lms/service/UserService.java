package com.zianedu.lms.service;

import com.zianedu.lms.mapper.UserMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    protected static final Logger logger = LoggerFactory.getLogger(UserService.class);

    public Integer test() {
        //logger.info(">>>>>>>>>>" + userMapper.selectExam());
        return userMapper.selectExam();
    }
}
