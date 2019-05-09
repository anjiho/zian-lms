package com.zianedu.lms.dto;

import com.zianedu.lms.vo.TCalculateOptionVO;
import lombok.Data;

import java.util.List;

@Data
public class TeacherCalculateResultDTO {

    private List<TeacherCalculateDTO> videoCalculateResult;

    private List<TeacherCalculateDTO> academyCalculateResult;

    private List<TeacherCalculateDTO> packageCalculateResult;

    private List<TCalculateOptionVO> calculateOptionList;

    public TeacherCalculateResultDTO() {}

    public TeacherCalculateResultDTO(List<TeacherCalculateDTO> videoCalculateResult,
                                     List<TeacherCalculateDTO> academyCalculateResult,
                                     List<TeacherCalculateDTO> packageCalculateResult,
                                     List<TCalculateOptionVO> calculateOptionList) {
        this.videoCalculateResult = videoCalculateResult;
        this.academyCalculateResult = academyCalculateResult;
        this.packageCalculateResult = packageCalculateResult;
        this.calculateOptionList = calculateOptionList;
    }
}
