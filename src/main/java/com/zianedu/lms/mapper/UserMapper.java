package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.TUserVO;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

public interface UserMapper {

    TUserVO getUserInfo(@Param("userId") String userId, @Param("userPass") String userPass);

    TUserVO getUserInfoByUserKey(@Param("userKey") int userKey);

    List<TUserVO> getUserList();

    void updateUserPwd(@Param("userKey") int userKey, @Param("userPwd") String userPwd);

    List<HashMap<String, Object>> selectAlgisaUser();

    TUserVO selectTeacherInfo(@Param("teacherKey") int teacherKey);

}
