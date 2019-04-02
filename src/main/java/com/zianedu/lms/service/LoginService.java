package com.zianedu.lms.service;

import com.zianedu.lms.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoginService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 로그인
     * @param userId
     * @param userPass
     * @return
     * @desc 유저가 있으면 true, 없으면 false
     */
    @Transactional(readOnly = true)
    public boolean login(String userId, String userPass) {
        if (userId == null) {
            return false;
        }
        Integer userCnt = userMapper.getUserCount(userId, userPass);
        if (userCnt > 0) {
            return true;
        }
        return false;
    }
}
