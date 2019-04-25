package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.StatisResultDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StatisManageMapper {

    List<StatisResultDTO> selectTotalStatisAtMonth(@Param("year") String year, @Param("goodsType") int goodsType);

    List<StatisResultDTO> selectTotalStatisAtYear(@Param("goodsType") int goodsType);

    List<StatisResultDTO> selectTotalStatisAtYearDay(@Param("month") String month, @Param("goodsType") int goodsType);
}
