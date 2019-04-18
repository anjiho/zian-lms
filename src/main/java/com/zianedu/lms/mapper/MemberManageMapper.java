package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.MemberSelectListDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberManageMapper {

    List<MemberSelectListDTO> selectMemberListBySelect(@Param("startNumber") int startNumber, @Param("listLimitNumber") int listLimitNumber,
                                                       @Param("searchText") String searchText, @Param("searchType") String searchType);

    int selectMemberListBySelectCount(@Param("searchText") String searchText, @Param("searchType") String searchType);
}
