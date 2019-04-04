package com.zianedu.lms.mapper;

import com.zianedu.lms.vo.TUserVO;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    TUserVO getUserInfo(@Param("userId") String userId, @Param("userPass") String userPass);

    TUserVO getUserInfoByUserKey(@Param("userKey") Long userKey);

}
