package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.TUserVO;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    Integer getUserCount(@Param("userId") String userId, @Param("userPass") String userPass);

    TUserVO getUserInfo(@Param("userKey") Long userKey);

}
