package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class ProblemBankListDTO {

    private int examQuestionBankKey;

    private String className;

    private String examYear;

    private String subjectName;

    private String levelName;

    private String typeName;

    private String patternName;

    private int unitCtgKey;

    private String unitName;

    private int examLevel;

    public ProblemBankListDTO(){}

    public ProblemBankListDTO(int examQuestionBankKey, String className, String examYear, String subjectName,
                              String levelName, String typeName, String patternName, String unitName) {
        this.examQuestionBankKey = examQuestionBankKey;
        this.className = className;
        this.examYear = examYear;
        this.subjectName = subjectName;
        this.levelName = levelName;
        this.typeName = typeName;
        this.patternName = patternName;
        this.unitName = unitName;
    }
}
