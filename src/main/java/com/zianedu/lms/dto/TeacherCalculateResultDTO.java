package com.zianedu.lms.dto;

import lombok.Data;

import java.util.List;

@Data
public class TeacherCalculateResultDTO {

    private List<TeacherCalculateDTO> videoCalculateResult;

    private List<TeacherCalculateDTO> academyCalculateResult;

    private List<TeacherCalculateDTO> packageCalculateResult;

    public TeacherCalculateResultDTO() {}

    public TeacherCalculateResultDTO(List<TeacherCalculateDTO> videoCalculateResult,
                                     List<TeacherCalculateDTO> academyCalculateResult,
                                     List<TeacherCalculateDTO> packageCalculateResult) {
        this.videoCalculateResult = videoCalculateResult;
        this.academyCalculateResult = academyCalculateResult;
        this.packageCalculateResult = packageCalculateResult;
    }
}
