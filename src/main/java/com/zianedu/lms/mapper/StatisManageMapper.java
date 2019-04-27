package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.StatisResultDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StatisManageMapper {

    List<StatisResultDTO> selectTotalStatisAtMonth(@Param("year") String year, @Param("goodsType") int goodsType);

    List<StatisResultDTO> selectTotalStatisAtYear(@Param("goodsType") int goodsType);

    List<StatisResultDTO> selectTotalStatisAtYearDay(@Param("month") String month, @Param("goodsType") int goodsType);

    List<StatisResultDTO> selectPackageStatisByMonth(@Param("year") String year, @Param("pmType") int pmType);

    List<StatisResultDTO> selectPackageStatisByYear(@Param("pmType") int pmType);

    List<StatisResultDTO> selectPackageStatisByDay(@Param("month") String month, @Param("pmType") int pmType);

    List<StatisResultDTO> selectMemberRegStatisByMonth(@Param("year") String year);

    List<StatisResultDTO> selectMemberRegStatisByYear();

    List<StatisResultDTO> selectMemberRegStatisByDay(@Param("month") String month);

}
