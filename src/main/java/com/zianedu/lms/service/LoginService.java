package com.zianedu.lms.service;

import com.zianedu.lms.mapper.UserMapper;
import com.zianedu.lms.vo.TUserVO;
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
     */
    @Transactional(readOnly = true)
    public TUserVO login(String userId, String userPass) {
        if ("".equals(userId)) return null;
        return userMapper.getUserInfo(userId, userPass);
    }

    public TUserVO getUserInfoByUserKey(Long userKey) {
        return userMapper.getUserInfoByUserKey(userKey);
    }

}
