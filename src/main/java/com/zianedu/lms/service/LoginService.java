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
     * 로그인(회원 존재 유무)
     * @param userId
     * @param userPass
     * @return
     */
    public Long login(String userId, String userPass) {
        if ("".equals(userId)) return null;
        return userMapper.getUserKey(userId, userPass);
    }

    /**
     * 회원정보 가져오기
     * @param userId
     * @param userPass
     * @return
     * @desc 유저가 있으면 TUserVo, 없으면 null;
     */
    @Transactional(readOnly = true)
    public TUserVO getUserInfo(Long userKey) {
        if (userKey == null) {
            return null;
        }
        return userMapper.getUserInfo(userKey);
    }
}
