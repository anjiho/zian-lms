package com.zianedu.lms.dto;

import lombok.Data;

@Data
public class ProblemBankSubjectDTO {

    private int examQuesBankKey;

    private int unitCtgKey;

    private int examYear;

    private int examLevel;

    private String unitName;

    private String levelName;

    private String subjectName;

    private String typeName;

    private String patternName;

    private String questionImage;

    private String questionImageUrl;

    private int pos;
}
