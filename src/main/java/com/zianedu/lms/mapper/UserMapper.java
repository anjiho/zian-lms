package com.zianedu.lms.mapper;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    Integer getUserCount(@Param("userId") String userId, @Param("userPass") String userPass);
}
