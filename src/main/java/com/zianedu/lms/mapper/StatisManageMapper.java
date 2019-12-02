package com.zianedu.lms.mapper;

import com.zianedu.lms.dto.StatisResultDTO;
import com.zianedu.lms.dto.TeacherCalculateDTO;
import com.zianedu.lms.vo.TCalculateOptionVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StatisManageMapper {

    /** SELECT **/

    List<StatisResultDTO> selectTotalStatisAtMonth(@Param("year") String year, @Param("goodsType") int goodsType);

    List<StatisResultDTO> selectTotalStatisAtYear(@Param("goodsType") int goodsType);

    List<StatisResultDTO> selectTotalStatisAtYearDay(@Param("month") String month, @Param("goodsType") int goodsType);

    List<StatisResultDTO> selectPackageStatisByMonth(@Param("year") String year, @Param("pmType") int pmType);

    List<StatisResultDTO> selectPackageStatisByYear(@Param("pmType") int pmType);

    List<StatisResultDTO> selectPackageStatisByDay(@Param("month") String month, @Param("pmType") int pmType);

    List<StatisResultDTO> selectMemberRegStatisByMonth(@Param("year") String year);

    List<StatisResultDTO> selectMemberRegStatisByYear();

    List<StatisResultDTO> selectMemberRegStatisByDay(@Param("month") String month);

    List<TeacherCalculateDTO> selectTeacherStatisByMonth(@Param("teacherKey") int teacherKey, @Param("goodsType") int goodsType,
                                                         @Param("month") String month);

    List<TeacherCalculateDTO> selectTeacherStatisBySection(@Param("teacherKey") int teacherKey, @Param("goodsType") int goodsType,
                                                           @Param("searchStartDate") String searchStartDate, @Param("searchEndDate") String searchEndDate);

    List<TCalculateOptionVO> selectTCalculateOptionList(@Param("teacherKey") int teacherKey, @Param("targetDate") String targetDate);

    List<StatisResultDTO> selectTeacherStatisGraphByMonth(@Param("teacherKey") int teacherKey, @Param("year") String year);

    List<StatisResultDTO> selectTeacherStatisGraphByYear(@Param("teacherKey") int teacherKey);

    List<StatisResultDTO> selectTeacherStatisGraphByDay(@Param("teacherKey") int teacherKey, @Param("month") String month);

    /** INSERT **/
    void insertTCalculateOption(TCalculateOptionVO tCalculateOptionVO);

    /** UPDATE **/
    void updateTCalculateOption(TCalculateOptionVO tCalculateOptionVO);

    /** DELETE **/
    void deleteTCalculateOption(@Param("calculateKey") int calculateKey);
}
