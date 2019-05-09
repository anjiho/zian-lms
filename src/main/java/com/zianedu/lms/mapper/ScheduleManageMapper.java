package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.CalculateInfoDTO;
import com.zianedu.lms.vo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ScheduleManageMapper {

    List<CalculateInfoDTO> selectCalculateListAtYesterdayByPayDate(@Param("yesterday") String yesterday, @Param("teacherKey") int teacherKey);

    List<CalculateInfoDTO> selectCalculateListAtYesterdayByCancelDate(@Param("yesterday") String yesterday, @Param("teacherKey") int teacherKey);
}
